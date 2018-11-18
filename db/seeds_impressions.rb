require "csv"
require "fileutils"

@publisher = User.publisher.where(first_name: "Mitch", last_name: "Taylor").first
@campaign_cache = {}

def build_impression(displayed_at)
  property = @publisher.properties.sample
  campaign = @campaign_cache[property.id] || Campaign.for_property(property).limit(1).first
  @campaign_cache[property.id] = campaign
  return nil unless campaign
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

def build_impressions(displayed_at, max_impressions_per_second: 25)
  rand(max_impressions_per_second + 1).times.map {
    build_impression displayed_at
  }.compact
end

def build_impressions_for_minute(time)
  displayed_at = Time.new(time.year, time.month, time.day, time.hour, time.min, 0, 0)
  impressions = []
  while displayed_at.min == time.min && displayed_at.sec <= 59
    impressions.concat build_impressions(displayed_at)
    displayed_at = displayed_at.advance(seconds: rand(11))
  end
  impressions
end

def build_impressions_for_hour(time)
  displayed_at = Time.new(time.year, time.month, time.day, time.hour, 0, 0, 0)
  impressions = []
  while displayed_at.hour == time.hour && displayed_at.min <= 59
    impressions.concat build_impressions_for_minute(displayed_at)
    displayed_at = displayed_at.advance(minutes: rand(3))
  end
  impressions
end

def build_impressions_for_day(date)
  displayed_at = Time.new(date.year, date.month, date.day, 0, 0, 0, 0)
  impressions = []
  while displayed_at.day == date.day && displayed_at.hour <= 23
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
  while current_date <= start_date.end_of_month
    csv_path = "/tmp/impressions-#{current_date.iso8601}.csv"
    puts "Creating #{csv_path}"
    list = build_impressions_for_day(current_date.to_time)
    CSV.open(csv_path, "wb") do |csv|
      list.each do |record|
        csv << record.values
      end
    end

    begin
      puts "Copying #{csv_path} with #{list.length} rows to Postgres"
      ActiveRecord::Base.connection.execute "COPY \"#{partition_table_name}\" FROM '#{csv_path}' CSV;"
    rescue => e
      puts "Failed to copy #{csv_path} to Postgres! #{e}"
    ensure
      FileUtils.rm_f csv_path, verbose: true
    end

    current_date = current_date.advance(days: 1)
  end
end

# This will create 30M impressions (give or take) when max_impressions_per_second is set to 6
# Currently configured to use 4 CPU cores... customize for the number of cores on your machine
# NOTE: this will peg your hardware for a while
# pids = [
#   Process.fork { sleep 0; create_impressions_for_month "2019-01-01" },
#   Process.fork { sleep 30; create_impressions_for_month "2019-02-01" },
#   Process.fork { sleep 60; create_impressions_for_month "2019-03-01" },
#   Process.fork { sleep 90; create_impressions_for_month "2019-04-01" },
# ]
# pids.each { |pid| Process.waitpid pid }

create_impressions_for_month "2019-10-01"
