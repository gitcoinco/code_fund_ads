# frozen_string_literal: true

require "benchmark"
require "csv"
require "etc"
require "fileutils"

class ImpressionSeeder
  def self.run
    new.call
  end

  def initialize
    @cores = Etc.nprocessors == 1 ? 1 : Etc.nprocessors - 1
    @count = (ENV["IMPRESSIONS"] || 100_000).to_f
    @months = (ENV["MONTHS"] || 12).to_i
  end

  def call
    cleanup_csv_files

    months_to_process = generate_impressions_months
    pids_being_processed = []

    while !months_to_process.empty? || !pids_being_processed.empty?
      while !months_to_process.empty? && pids_being_processed.size < @cores
        month = months_to_process.pop

        pid = fork_process_with_db_connection do
          monthly_dates = generate_impressions_dates(month)
          daily_timestamps = generate_daily_timestamps(monthly_dates)

          campaigns = Campaign.active.available_on(daily_timestamps.first)
          properties = []

          campaigns.each do |campaign|
            properties[campaign.id] ||= Property.for_campaign(campaign)
          end

          advertisers = []
          records = []

          daily_timestamps.each do |timestamp|
            campaign = campaigns.sample
            property = properties[campaign.id].sample

            impression = Impression.new(
              id: SecureRandom.uuid,
              campaign_id: campaign.id,
              property_id: property.id,
              advertiser_id: campaign.user_id,
              publisher_id: property.user_id,
              organization_id: campaign.organization_id,
              creative_id: campaign.creative_id,
              ad_template: "default",
              ad_theme: "light",
              displayed_at: timestamp,
              displayed_at_date: timestamp.to_date,
              clicked_at: rand(1000) <= 4 ? (timestamp + rand(86400)) : nil,
              ip_address: rand(6).zero? ? Faker::Internet.ip_v6_address : Faker::Internet.public_ip_v4_address,
              user_agent: Faker::Internet.user_agent,
              country_code: rand(6).zero? ? "US" : Country.all.sample.iso_code,
              fallback_campaign: campaign.fallback
            )

            if !advertisers.include? impression.advertiser_id 
              advertisers << impression.advertiser_id
              impression.assure_partition_table!
            end

            records << impression.attributes
          end

          csv_path = csv_file_name(daily_timestamps.first)
          CSV.open(csv_path, "wb") do |csv|
            records.each { |record| csv << record.values }
          end
        end

        pids_being_processed << pid
      end

      if (completed_pid = Process.waitpid(0, Process::WNOHANG))
        pids_being_processed.delete(completed_pid)
      end
    end

    bulk_copy_csv_files
  end

  private

  def generate_impressions_months
    months = [Date.current.beginning_of_month]
    (@months - 1).times { months << months.last.advance(months: -1) }
    months
  end

  def generate_impressions_dates(month)
    days = []
    days << month.beginning_of_month

    (month.end_of_month.day - 1).times do
      days << days.last.advance(days: 1)
    end

    days
  end

  def daily_impression_count(dates)
    monthly_count = (@count / @months.to_f).ceil
    daily_count = (monthly_count.to_f / dates.count.to_f).ceil
    daily_count
  end

  def generate_daily_timestamps(dates)
    timestamps = []

    dates.each do |day|
      daily_weights = random_weighted_freq(day)

      daily_impression_count(dates).times do
        sampled_hour = random_weighted_sample(daily_weights)
        timestamps << generate_minute_timestamp(sampled_hour)
      end
    end

    timestamps
  end

  def generate_hourly_timestamps(date)
    hours_of_day = []

    hours_of_day << Time.new(date.year, date.month, date.day, 0, 0, 0, 0)
    date.end_of_day.hour.times do
      hours_of_day << hours_of_day.last.advance(hours: 1)
    end

    hours_of_day
  end

  def generate_minute_timestamp(hour)
    hour + rand(3600)
  end

  def after_hours?(timestamp)
    timestamp.hour.between?(17, 21)
  end

  def business_hours?(timestamp)
    timestamp.hour.between?(8, 17)
  end

  def nights?(timestamp)
    timestamp.hour.between?(0, 6)
  end

  def weekend?(timestamp)
    timestamp.saturday? || timestamp.sunday?
  end

  def random_weighted_freq(date)
    hours_of_day = generate_hourly_timestamps(date)

    weights = hours_of_day.map { |timestamp|
      if business_hours?(timestamp) && !weekend?(timestamp)
        10
      elsif after_hours?(timestamp) && !weekend?(timestamp)
        6
      elsif weekend?(timestamp) && !nights?(timestamp)
        6
      elsif nights?(timestamp)
        2
      else
        4
      end
    }

    hours_of_day.zip(weights).to_h
  end

  def random_weighted_sample(daily_weights)
    daily_weights.max_by { |_, weight| rand**(1.0 / weight) }.first
  end

  def fork_process_with_db_connection
    ActiveRecord::Base.remove_connection

    pid = Process.fork {
      begin
        ActiveRecord::Base.establish_connection
        yield
      rescue => e
        puts "FAILED: Forked process failed with error - #{e}"
      ensure
        ActiveRecord::Base.remove_connection
      end
    }

    ActiveRecord::Base.establish_connection
    pid
  end

  def csv_file_name(timestamp)
    "db/data/Impressions_#{timestamp.strftime("%B")}_#{timestamp.year}.csv"
  end

  def cleanup_csv_files
    Dir.glob(Rails.root.join("db", "data", "*.csv")).each do |file|
      FileUtils.rm_f file
    end
  end

  def bulk_copy_csv_files
    raw_conn = ActiveRecord::Base.connection.raw_connection

    begin
      Dir.glob(Rails.root.join("db", "data", "*.csv")).each do |file|
        raw_conn.copy_data("COPY impressions FROM STDIN (FORMAT CSV)") do
          CSV.foreach(file) do |row|
            raw_conn.put_copy_data(CSV.generate_line(row, force_quotes: false))
          end
        end
      end
    rescue Error => e
      puts "FAILED: bulk copy of csv files with error - #{e}"
    end
  end
end
