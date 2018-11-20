# frozen_string_literal: true

require "etc"
require "csv"
require "fileutils"

class ImpressionSeeder
  def self.run(max_impressions)
    new(max_impressions).call
  end

  def initialize(max_impressions)
    @processes = (Etc.nprocessors - 1)
    @processes = 1 if @processes < 1
    @max_impressions = max_impressions
    @count = Impression.count
    @publishers = User.publisher.includes(:properties).load
    @campaign_cache = {}
    max_impressions = 1000 if max_impressions.to_i == 0
    @max_impressions_per_second = ((max_impressions / @processes.to_f) / 1.month.seconds.to_f).ceil
  end

  def call
    # This will create 30M impressions (give or take) when @max_impressions_per_second is set to 6
    # Currently configured to use 4 CPU cores... customize for the number of cores on your machine
    # NOTE: this will peg your hardware for a while
    puts "[SEEDING DATABASE]: Seeding impressions"
    pids = @processes.times.map do
      Process.fork { create_impressions_for_month "2019-#{(1..12).to_a.sample}-01" }
    end
    pids.each { |pid| Process.waitpid pid }
    puts "[SEEDING DATABASE]: Seeding impressions done"
  end

  private

  def incomplete?
    @count < @max_impressions
  end

  def build_impression(displayed_at)
    property = @publishers.sample.properties.sample
    campaigns = @campaign_cache[property.id]
    campaigns ||= Campaign.for_property(property)
    @campaign_cache[property.id] = campaigns
    campaign = campaigns.sample
    return nil unless campaign
    @count += 1
    {
      id: SecureRandom.uuid,
      campaign_id: campaign.id,
      property_id: property.id,
      ip: rand(6).zero? ? Faker::Internet.ip_v6_address : Faker::Internet.public_ip_v4_address,
      user_agent: Faker::Internet.user_agent,
      country: rand(6).zero? ? ENUMS::COUNTRIES["United States"] : ENUMS::COUNTRIES.keys.sample,
      postal_code: nil,
      latitude: nil,
      longitude: nil,
      payable: rand(10).zero? ? false : true,
      reason: nil,
      displayed_at: displayed_at,
      displayed_at_date: displayed_at.to_date,
      clicked_at: rand(100) <= 2 ? displayed_at : nil,
      fallback_campaign: campaign.fallback,
    }
  end

  def build_impressions(displayed_at)
    rand(@max_impressions_per_second + 1).times.map {
      build_impression displayed_at
    }.compact
  end

  def build_impressions_for_minute(time)
    displayed_at = Time.new(time.year, time.month, time.day, time.hour, time.min, 0, 0)
    impressions = []
    while incomplete? && displayed_at.min == time.min && displayed_at.sec <= 59
      impressions.concat build_impressions(displayed_at)
      displayed_at = displayed_at.advance(seconds: rand(11))
    end
    impressions
  end

  def build_impressions_for_hour(time)
    displayed_at = Time.new(time.year, time.month, time.day, time.hour, 0, 0, 0)
    impressions = []
    while incomplete? && displayed_at.hour == time.hour && displayed_at.min <= 59
      impressions.concat build_impressions_for_minute(displayed_at)
      displayed_at = displayed_at.advance(minutes: rand(3))
    end
    impressions
  end

  def build_impressions_for_day(date)
    displayed_at = Time.new(date.year, date.month, date.day, 0, 0, 0, 0)
    impressions = []
    while incomplete? && displayed_at.day == date.day && displayed_at.hour <= 23
      impressions.concat build_impressions_for_hour(displayed_at)
      displayed_at = displayed_at.advance(hours: 1)
    end
    impressions
  end

  def create_impressions_for_month(date_string)
    start_date = Date.parse(date_string).beginning_of_month
    return if Impression.where(displayed_at: start_date).count > 0
    partition_table_name = "impressions_#{start_date.to_s "yyyy_mm"}"
    current_date = start_date
    while incomplete? && current_date <= start_date.end_of_month
      csv_path = "/tmp/impressions-#{current_date.iso8601}.csv"
      puts "[SEEDING DATABASE]: Creating #{csv_path}"
      list = build_impressions_for_day(current_date.to_time)
      CSV.open(csv_path, "wb") do |csv|
        list.each do |record|
          csv << record.values
        end
      end

      begin
        puts "[SEEDING DATABASE]: Copying #{csv_path} with #{list.length} rows to Postgres"
        ActiveRecord::Base.connection.execute "COPY \"#{partition_table_name}\" FROM '#{csv_path}' CSV;"
      rescue => e
        puts "[SEEDING DATABASE]: Failed to copy #{csv_path} to Postgres! #{e}"
      ensure
        FileUtils.rm_f csv_path, verbose: true
      end

      current_date = current_date.advance(days: 1)
    end
  end
end
