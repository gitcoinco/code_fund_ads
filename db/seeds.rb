# frozen_string_literal: true

require "benchmark"
require "csv"
require "faker"
require "fileutils"
require_relative "./campaign_seeder"
require_relative "./impression_seeder"

unless Rails.env.development? || ENV["ALLOW_SEED"] == "true"
  puts "SEEDS ARE FOR DEVELOPMENT ONLY!"
  exit 1
end

class Seeder
  def self.run
    new.call
  end

  def initialize
    @user_id = User.maximum(:id).to_i
    @property_id = Property.maximum(:id).to_i
    @emails = User.all.pluck(:email).each_with_object({}) { |email, memo|
      memo[email] = true
    }
    @impressions = ENV["IMPRESSIONS"].to_i
    @impressions = 100_000 if @impressions < 100_000
    @months = (ENV["MONTHS"] || 12).to_i
    @months = @months.to_i.zero? ? 12 : @months.to_i
    @months = 12 if @months < 12
  end

  def call
    print "Seeding...".ljust(48)
    puts "please be patient"
    benchmark = Benchmark.measure {
      seed_users
      seed_campaigns
      seed_properties
      ImpressionSeeder.run(@impressions, @months)
    }
    print "Seeding finished...".ljust(96)
    puts benchmark
  end

  private

  def seed_users
    print "Seeding users...".ljust(48)
    benchmark = Benchmark.measure {
      users = build_administrators
      users.concat build_advertisers
      users.concat build_publishers
      import_csv :users, create_csv(users, Rails.root.join("tmp/users.csv")), User.sequence_name unless users.blank?
    }
    print "verified [#{User.count.to_s.rjust(8)}] total users".ljust(48)
    puts benchmark
  end

  def build_administrators
    return [] unless User.administrators.count.zero?
    return [] if @emails["admin@codefund.io"]
    attributes = user_attributes.merge(
      "id" => @user_id += 1,
      "company_name" => "CodeFund",
      "email" => "admin@codefund.io",
      "roles" => "{#{ENUMS::USER_ROLES::ADMINISTRATOR}}",
    )
    [attributes.values]
  end

  def build_advertisers
    target = 250
    count = User.advertisers.count
    return [] if count >= target
    (count..target).map do
      user_attributes.merge(
        "id" => @user_id += 1,
        "roles" => "{#{ENUMS::USER_ROLES::ADVERTISER}}"
      ).values
    end
  end

  def build_publishers
    target = 1000
    count = User.publishers.count
    return [] if count >= target
    (count..target).map do
      user_attributes.merge(
        "id" => @user_id += 1,
        "roles" => "{#{ENUMS::USER_ROLES::PUBLISHER}}"
      ).values
    end
  end

  def seed_campaigns
    print "Seeding campaigns...".ljust(48)
    benchmark = Benchmark.measure {
      User.advertisers.each do |advertiser|
        next if advertiser.campaigns.count > 0
        add_small_image advertiser
        add_large_image advertiser
        add_wide_image advertiser
        generate_creatives advertiser
        generate_campaigns advertiser
      end
    }
    print "verified [#{Campaign.count.to_s.rjust(8)}] total campaigns".ljust(48)
    puts benchmark
  end

  def add_small_image(advertiser)
    advertiser.images.attach io: File.open(Rails.root.join("app/assets/images/seeds/seed-200x200.png")),
      filename: "seed-200x200.png",
      content_type: "image/png",
      metadata: {
        identified: true,
        width: 200,
        height: 200,
        analyzed: true,
        name: "seed-200x200.png",
        format: ENUMS::IMAGE_FORMATS::SMALL,
      }
  end

  def add_large_image(advertiser)
    advertiser.images.attach io: File.open(Rails.root.join("app/assets/images/seeds/seed-260x200.png")),
      filename: "seed-260x200.png",
      content_type: "image/png",
      metadata: {
        identified: true,
        width: 260,
        height: 200,
        analyzed: true,
        name: "seed-260x200.png",
        format: ENUMS::IMAGE_FORMATS::LARGE,
      }
  end

  def add_wide_image(advertiser)
    advertiser.images.attach io: File.open(Rails.root.join("app/assets/images/seeds/seed-512x320.jpg")),
      filename: "seed-512x320.jpg",
      content_type: "image/jpeg",
      metadata: {
        identified: true,
        width: 512,
        height: 320,
        analyzed: true,
        name: "seed-512x320.jpg",
        format: ENUMS::IMAGE_FORMATS::WIDE,
      }
  end

  def generate_creatives(advertiser)
    5.times do
      creative = Creative.create(
        user: advertiser,
        name: Faker::SiliconValley.company,
        headline: Faker::SiliconValley.invention,
        body: Faker::SiliconValley.motto,
      )
      advertiser.images.each do |image|
        CreativeImage.create creative: creative, image: image
      end
    end
  end

  def campaign_dates
    @campaign_dates ||= (Date.current.advance(months: @months * -1)..Date.current).to_a
  end

  def generate_campaigns(advertiser)
    rand(2..8).times do
      CampaignSeeder.create_campaign advertiser, campaign_dates.sample
    end
  end

  def seed_properties
    print "Seeding properties...".ljust(48)
    benchmark = Benchmark.measure {
      properties = User.publishers.each_with_object([]) { |publisher, memo|
        next if publisher.properties.count > 0
        rand(1..2).times.each do
          property = Property.new(
            id: @property_id += 1,
            user_id: publisher.id,
            property_type: ENUMS::PROPERTY_TYPES.values.sample,
            status: rand(5).zero? ? ENUMS::PROPERTY_STATUSES.values.sample : ENUMS::PROPERTY_STATUSES::ACTIVE,
            name: "#{Faker::SiliconValley.invention} #{SecureRandom.hex.upcase[0, 6]}",
            url: Faker::SiliconValley.url,
            ad_template: ENUMS::AD_TEMPLATES.values.sample,
            ad_theme: ENUMS::AD_THEMES.values.sample,
            language: ENUMS::LANGUAGES::ENGLISH,
            prohibit_fallback_campaigns: false,
            created_at: Time.current,
            updated_at: Time.current,
          )
          attributes = property.attributes.merge(
            "keywords" => "{#{ENUMS::KEYWORDS.values.sample(25).join(",")}}",
            "prohibited_advertiser_ids" => "{}"
          )
          memo << attributes.values
        end
      }
      import_csv :properties, create_csv(properties, Rails.root.join("tmp/properties.csv")), Property.sequence_name unless properties.blank?
    }
    print "verified [#{Property.count.to_s.rjust(8)}] total properties".ljust(48)
    puts benchmark
  end

  def create_csv(list, csv_path)
    CSV.open(csv_path, "wb") do |csv|
      list.each do |record|
        csv << record
      end
    end
    csv_path
  end

  def import_csv(table_name, csv_path, sequence_name)
    model = table_name.to_s.classify.constantize
    config = model.connection_config
    command = ["PGPASSWORD=#{config[:password]} psql #{config[:database]}"]
    command << "-h #{config[:host]}" if config[:host].present?
    command << "-p #{config[:port]}" if config[:port].present?
    command << "-U #{config[:username]}" if config[:username].present?
    command << "-c \"copy #{table_name} from '#{csv_path}' CSV\""
    system command.join(" ")

    ActiveRecord::Base.connection.execute "SELECT SETVAL('#{sequence_name}', (SELECT MAX(id) FROM #{table_name}) + 1);"
  rescue => e
    puts "Failed to copy #{csv_path} to Postgres! #{e}"
  ensure
    FileUtils.rm_f csv_path
  end

  def user_attributes
    @encrypted_password ||= User.new(password: "secret").encrypted_password
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = Faker::Internet.email("#{first_name} #{last_name} #{SecureRandom.hex[0, 8]}", "-")
    user = User.new(
      first_name: first_name,
      last_name: last_name,
      company_name: Faker::SiliconValley.company,
      email: email,
      encrypted_password: @encrypted_password,
      confirmation_token: Devise.friendly_token,
      confirmed_at: 1.day.ago,
      confirmation_sent_at: 2.days.ago,
      invitation_token: nil,
      invitation_created_at: 3.days.ago,
      invitation_sent_at: 3.days.ago,
      invitation_accepted_at: 1.day.ago,
      invited_by_type: "User",
      invited_by_id: 1,
      invitations_count: 1,
      us_resident: true,
      github_username: Faker::Twitter.screen_name,
      twitter_username: Faker::Twitter.screen_name,
      created_at: 3.days.ago,
      updated_at: 3.days.ago,
    )
    user.attributes.merge(
      "roles" => "{}",
      "skills" => "{}",
    )
  end
end

Seeder.run
