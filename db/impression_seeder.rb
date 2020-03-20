# frozen_string_literal: true

require "etc"

class ImpressionSeeder
  def self.run
    puts "Seeding impressions"
    new.call
  end

  def initialize
    @pid_count = Etc.nprocessors - 1
    @pid_count = 1 if @pid_count < 1
    @count = (ENV["IMPRESSIONS"] || 100_000).to_f
    @months = 12.times.map { |i| i.months.ago.beginning_of_month.to_date }.reverse
  end

  def call
    partition_tables = {}
    users = User.all.each_with_object({}) { |user, memo| memo[user.id] = user }
    campaigns = Campaign.active.to_a
    properties = campaigns.each_with_object({}) { |campaign, memo|
      memo[campaign.id] ||= Property.for_campaign(campaign).to_a
    }
    ip_addresses = 5000.times.map { rand(10).zero? ? Faker::Internet.ip_v6_address : Faker::Internet.public_ip_v4_address }

    slice_size = (@months.size / @pid_count.to_f).ceil
    @months.each_slice slice_size do |months|
      next unless months.size > 0
      Process.fork {
        sleep rand(0.1..6)
        while months.present?
          monthly_dates = generate_impressions_dates(months.shift)
          impressions = generate_daily_timestamps(monthly_dates).map { |timestamp|
            campaign = begin
                         campaigns.select { |c| c.available_on? timestamp }.sample
                       rescue
                         nil
                       end
            property = begin
                         properties[campaign&.id].sample
                       rescue
                         nil
                       end
            clicked_at = rand(1000) <= 3 ? timestamp : nil

            if campaign && property
              impression = Impression.new(
                id: SecureRandom.uuid,
                campaign: campaign,
                property: property,
                advertiser: users[campaign.user_id],
                publisher: users[property.user_id],
                organization: campaign.organization,
                creative: campaign.creatives.sample,
                ad_template: property.ad_template,
                ad_theme: property.ad_theme,
                displayed_at: timestamp,
                displayed_at_date: timestamp.to_date,
                clicked_at: clicked_at,
                clicked_at_date: clicked_at&.to_date,
                ip_address: ip_addresses.sample,
                user_agent: Faker::Internet.user_agent,
                country_code: campaign.country_codes.sample,
                fallback_campaign: campaign.fallback
              )

              impression.calculate_estimated_revenue

              unless partition_tables[impression.partition_table_name]
                impression.assure_partition_table!
                partition_tables[impression.partition_table_name] = true
              end

              impression.attributes
            end
          }

          impressions.compact!
          Impression.insert_all impressions unless impressions.blank?
        end
      }
    end

    Process.wait
  end

  private

  def generate_impressions_dates(month)
    days = []
    days << month.beginning_of_month

    (month.end_of_month.day - 1).times do
      days << days.last.advance(days: 1)
    end

    days
  end

  def daily_impression_count(dates)
    monthly_count = (@count / @months.size.to_f).ceil
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
end
