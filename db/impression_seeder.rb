# frozen_string_literal: true

require "benchmark"
require "csv"
require "etc"
require "fileutils"

class ImpressionSeeder
  def self.run(desired_count)
    new(desired_count).call
  end

  attr_reader :initial_count, :max_count, :gap_count

  def initialize(desired_count)
    puts "Seeding impressions start..."
    @initial_count = Impression.count
    @max_count = desired_count.to_i.zero? ? 10_000 : desired_count.to_i
    @gap_count = max_count - initial_count
    @publishers = User.publisher.includes(:properties).load
    @campaign_cache = Property.all.each_with_object({}).each do |property, memo|
      memo[property.id] = Campaign.for_property(property).load
    end
  end

  def cores
    @cores ||= begin
      cores = Etc.nprocessors - 1
      cores = 1 if cores < 1
      cores
    end
  end

  def max_count_per_core
    @max_count_per_core ||= (max_count / cores.to_f).floor
  end

  def call
    if initial_count < max_count
      benchmark = Benchmark.measure {
        pids = cores.times.map {
          Process.fork do
            (1..12).each do |i|
              create_impressions_for_month "2019-#{i.to_s.rjust(2, "0")}-01", max_count_per_core / 12
            end
          end
        }
        pids.each { |pid| Process.waitpid pid }
      }
    end
    print "Seeding impressions finish...".ljust(48)
    print "verified [#{Impression.count.to_s.rjust(8)}] total impressions".ljust(48)
    puts benchmark
  end

  private

  def incomplete?
    @count < @max
  end

  def build_impression(displayed_at)
    property = @publishers.sample.properties.sample
    campaign = @campaign_cache[property.id].sample
    return nil unless campaign
    @count += 1
    {
      id: SecureRandom.uuid,
      campaign_id: campaign.id,
      campaign_name: campaign.name,
      property_id: property.id,
      property_name: property.name,
      ip: rand(6).zero? ? Faker::Internet.ip_v6_address : Faker::Internet.public_ip_v4_address,
      user_agent: Faker::Internet.user_agent,
      country_code: rand(6).zero? ? ENUMS::COUNTRIES["United States"] : ENUMS::COUNTRIES.keys.sample,
      postal_code: nil,
      latitude: nil,
      longitude: nil,
      payable: rand(10).zero? ? false : true,
      reason: nil,
      displayed_at: displayed_at,
      displayed_at_date: displayed_at.to_date,
      clicked_at: rand(100) <= 1 ? displayed_at : nil,
      fallback_campaign: campaign.fallback,
    }
  end

  def build_impressions(displayed_at)
    multiplier = displayed_at.hour.between?(0, 6) || displayed_at.hour.between?(13, 21) ? 1 : 0
    max_per_second = (@max / 1.month.seconds.to_f).ceil + multiplier
    rand(max_per_second + 1).times.map {
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

  def create_impressions_for_month(date_string, max)
    @count = 0
    @max = max
    start_date = Date.parse(date_string).beginning_of_month
    partition_table_name = "impressions_#{start_date.to_s "yyyy_mm"}"
    current_date = start_date
    while incomplete? && current_date <= start_date.end_of_month
      error = nil
      benchmark = Benchmark.measure {
        list = build_impressions_for_day(current_date.to_time)
        csv_path = "/tmp/impressions-#{Process.pid}-#{current_date.iso8601}.csv"
        CSV.open(csv_path, "wb") do |csv|
          list.each do |record|
            csv << record.values
          end
        end

        begin
          ActiveRecord::Base.connection.execute "COPY \"#{partition_table_name}\" FROM '#{csv_path}' CSV;"
        rescue => e
          error = e
          puts "Failed to copy #{csv_path} to Postgres! #{e}"
        ensure
          FileUtils.rm_f csv_path
        end
      }

      if error.nil?
        message = "Seeding impressions ##{Process.pid} #{current_date.iso8601}...".ljust(96)
        message += benchmark.to_s
        puts message
      end

      current_date = current_date.advance(days: 1)
    end
  end
end
