# frozen_string_literal: true

require "benchmark"
require "csv"
require "etc"
require "fileutils"
require_relative "./campaign_seeder"

class ImpressionSeeder
  def self.run(desired_count, months)
    new(desired_count, months).call
  end

  attr_reader :initial_count, :max_count, :gap_count, :months

  def initialize(desired_count, months)
    print "Seeding impressions start...".ljust(48)

    @months = months
    @initial_count = Impression.count
    @max_count = desired_count
    @gap_count = max_count - initial_count
    @gap_count = 0 if @gap_count < 0
    @cores = [months, cores].min
    @partition_tables = {}

    puts "creating [#{gap_count.to_s.rjust(8)}] new impressions spread over [#{months}] months using [#{cores}] cpu cores"
    print "".ljust(48)
    puts "...the count is an estimate due to randomness added to mimic real world behavior"
  end

  def cores
    @cores ||= Etc.nprocessors == 1 ? 1 : Etc.nprocessors - 1
  end

  def max_count_per_core
    (gap_count / cores.to_f).floor
  end

  def call
    if initial_count < max_count
      benchmark = Benchmark.measure {
        dates = [Date.current.beginning_of_month]
        months.times { dates << dates.last.advance(months: -1) }
        chunked_dates = dates.in_groups_of((months / cores.to_f).ceil)
        pids = cores.times.map { |i|
          Process.fork do
            pid_dates = chunked_dates[i].compact
            max = (max_count_per_core / pid_dates.size.to_f).ceil
            pid_dates.each { |date| create_impressions_for_month date.iso8601, max }
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

  def advertisers
    @advertisers ||= User.advertisers.includes(:creatives).to_a
  end

  def campaigns(displayed_at)
    @campaigns ||= {}
    @campaigns[displayed_at.to_date] ||= Campaign.active.available_on(displayed_at).includes(:user).to_a
    @campaigns[displayed_at.to_date] << CampaignSeeder.create_campaign(advertisers.sample, displayed_at) while @campaigns[displayed_at.to_date].size < 5
    @campaigns[displayed_at.to_date]
  end

  def properties(campaign)
    @properties ||= []
    @properties[campaign.id] ||= Property.for_campaign(campaign).includes(:user).to_a
  end

  def incomplete?
    @count < @max
  end

  def build_impression(displayed_at)
    campaign = campaigns(displayed_at).sample
    return nil unless campaign

    property = properties(campaign).sample
    return nil unless property

    @count += 1
    impression = Impression.new(
      id: SecureRandom.uuid,
      advertiser_id: campaign.user_id,
      publisher_id: property.user_id,
      campaign_id: campaign.id,
      creative_id: campaign.creative_id,
      property_id: property.id,
      campaign_name: campaign.scoped_name,
      property_name: property.scoped_name,
      ip_address: rand(6).zero? ? Faker::Internet.ip_v6_address : Faker::Internet.public_ip_v4_address,
      user_agent: Faker::Internet.user_agent,
      country_code: rand(6).zero? ? ENUMS::COUNTRIES["United States"] : ENUMS::COUNTRIES.keys.sample,
      displayed_at: displayed_at,
      displayed_at_date: displayed_at.to_date,
      clicked_at: rand(100) <= 3 ? displayed_at : nil,
      fallback_campaign: campaign.fallback,
    )
    @partition_tables[impression.partition_table_name] ||= begin
      impression.assure_partition_table!
      true
    end
    impression.attributes
  end

  def core_hours?(displayed_at)
    displayed_at.hour.between?(0, 6) || displayed_at.hour.between?(13, 21)
  end

  def build_impressions(displayed_at)
    chance = @max_per_second
    chance = (chance / 2.to_f).ceil unless core_hours?(displayed_at)
    count = rand(1..chance)
    count.times.map { build_impression(displayed_at) }.compact
  end

  def build_impressions_for_minute(time)
    displayed_at = Time.new(time.year, time.month, time.day, time.hour, time.min, 0, 0)
    impressions = []
    while incomplete? && displayed_at.min == time.min && displayed_at.sec <= 59
      new_impressions = build_impressions(displayed_at)
      impressions.concat new_impressions
      @count += 1 if new_impressions.size.zero?
      displayed_at = displayed_at.advance(seconds: rand(1..10))
    end
    impressions
  end

  def build_impressions_for_hour(time)
    displayed_at = Time.new(time.year, time.month, time.day, time.hour, 0, 0, 0)
    impressions = []
    while incomplete? && displayed_at.hour == time.hour && displayed_at.min <= 59
      impressions.concat build_impressions_for_minute(displayed_at)
      displayed_at = displayed_at.advance(minutes: rand(1..5))
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
    @max_per_second = (max / 1.month.seconds.to_f).ceil * 4
    start_date = Date.parse(date_string).beginning_of_month
    active_date = start_date
    list = []
    error = nil

    benchmark = Benchmark.measure {
      while incomplete? && active_date <= start_date.end_of_month
        list.concat build_impressions_for_day(active_date.to_time)
        active_date = active_date.advance(days: 1)
      end

      csv_path = "/tmp/impressions-#{Process.pid}.csv"
      CSV.open(csv_path, "wb") do |csv|
        list.each { |record| csv << record.values }
      end

      begin
        config = Impression.connection_config
        command = ["PGPASSWORD=#{config[:password]} psql #{config[:database]}"]
        command << "-h #{config[:host]}" if config[:host].present?
        command << "-p #{config[:port]}" if config[:port].present?
        command << "-U #{config[:username]}" if config[:username].present?
        command << "-c \"copy impressions from '#{csv_path}' CSV\""
        system command.join(" ")
      rescue => e
        error = e
        puts "Failed to copy #{csv_path} to Postgres! #{e}"
      ensure
        FileUtils.rm_f csv_path
      end
    }

    unless error
      message = "Seeding impressions #{date_string}...".ljust(48)
      message += "created [#{list.size}] records with pid: #{Process.pid}".ljust(48)
      message += benchmark.to_s
      puts message
    end
  end
end
