# frozen_string_literal: true

require "benchmark"
require "csv"
require "etc"
require "fileutils"

class ImpressionSeeder
  def self.run(count = 100000, months = 12)
    new(count, months).call
  end

  def initialize(count = 100000, months = 12)
    @cores = machine_cores
    @impressions_count = count
    @months = months
  end

  def call
    cleanup_all_csv_files
    generate_new_impressions
    bulk_copy_all_csv_files
  end

  private

  def generate_new_impressions
    items_to_process = generate_impressions_timestamps
    pids_being_processed = []

    while !items_to_process.empty? || !pids_being_processed.empty?
      while items_to_process.size < @cores && !items_to_process.size.zero?
        item = items_to_process.pop

        pid = fork_process_with_db_connection {
          ActiveRecord::Base.connection.reconnect!

          campaign = Campaign.active.available_on(item.first).sample
          property = Property.for_campaign(campaign).sample
          advertiser_id = campaign.user.id
          publisher_id = property.user.id
          organization_id = campaign.user.organization.id
          creative_id = campaign.creatives.ids.sample

          records = []

          item.each_with_index do |timestamp, index|
            impression = generate_single_impression(campaign,
              property.id,
              advertiser_id,
              publisher_id,
              organization_id,
              creative_id,
              timestamp)

            if index == 0
              impression.assure_partition_table!
            end

            records << impression.attributes
          end

          csv_path = csv_file_name(item.first)
          CSV.open(csv_path, "wb") do |csv|
            records.each { |record| csv << record.values }
          end
        }

        pids_being_processed << pid
      end

      if (done = Process.waitpid(0, Process::WNOHANG))
        pids_being_processed.delete(done)
      end

      sleep(0.1)
    end
  end

  def generate_single_impression(campaign, property_id, advertiser_id, publisher_id, organization_id, creative_id, timestamp)
    Impression.new(
      id: SecureRandom.uuid,
      campaign_id: campaign.id,
      property_id: property_id,
      advertiser_id: advertiser_id,
      publisher_id: publisher_id,
      organization_id: organization_id,
      creative_id: creative_id,
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
  end

  def daily_impressions_count(impression_dates)
    (@impressions_count.to_f / impression_dates.flatten.count.to_f).ceil
  end

  def generate_impressions_timestamps
    impression_dates = generate_impressions_dates

    daily_impression_count = daily_impressions_count(impression_dates)

    impression_dates.each_with_index.map do |days, index|
      impression_timestamps = []

      days.each do |day|
        daily_weights = random_weighted_freq(day)

        daily_impression_count.times do
          sampled_hour = random_weighted_sample(daily_weights)
          impression_timestamps << generate_random_minute_timestamp(sampled_hour)
        end
      end

      impression_timestamps
    end
  end

  def generate_impressions_dates
    months = [Date.current.beginning_of_month]
    (@months - 1).times { months << months.last.advance(months: -1) }

    months.each_with_index.map do |interval, index|
      days = []
      days << interval.beginning_of_month
      (interval.end_of_month.day - 1).times do
        days << days.last.advance(days: 1)
      end
      days
    end
  end

  def generate_hourly_timestamps(date)
    hours_of_day = []

    hours_of_day << Time.new(date.year, date.month, date.day, 0, 0, 0, 0)
    date.end_of_day.hour.times do
      hours_of_day << hours_of_day.last.advance(hours: 1)
    end

    hours_of_day
  end

  def generate_random_minute_timestamp(hour)
    hour + rand(3600)
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

  def csv_file_name(timestamp)
    "db/data/impressions_#{timestamp.strftime("%B").downcase}_#{timestamp.year}.csv"
  end

  def cleanup_all_csv_files
    Dir.glob(Rails.root.join("db", "data", "*.csv")).each do |file|
      FileUtils.rm_f file
    end
  end

  def bulk_copy_all_csv_files
    raw_conn = ActiveRecord::Base.connection.raw_connection

    begin
      Dir.glob(Rails.root.join("db", "data", "*.csv")).each do |file|
        raw_conn.copy_data("COPY impressions FROM STDIN (FORMAT CSV)") do
          CSV.foreach(file) do |row|
            raw_conn.put_copy_data(CSV.generate_line(row, force_quotes: false))
          end
        end
      end
    rescue => e
      puts "FAILED: bulk copy of csv files with error - #{e}"
    end
  end

  def fork_process_with_db_connection
    config = ActiveRecord::Base.remove_connection

    pid = Process.fork {
      success = true

      begin
        ActiveRecord::Base.establish_connection(config)
        yield
      rescue => e
        puts "FAILED: Forked process failed with error - #{e}"
        success = false
      ensure
        ActiveRecord::Base.remove_connection
        Process.exit! success
      end
    }

    ActiveRecord::Base.establish_connection(config)
    pid
  end

  def machine_cores
    Etc.nprocessors == 1 ? 1 : Etc.nprocessors - 1
  end
end
