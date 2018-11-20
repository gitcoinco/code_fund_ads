# frozen_string_literal: true

require "csv"
require "fileutils"
require "faker"

require_relative "./seeds_impressions"

unless Rails.env.development?
  puts "SEEDS ARE FOR DEVELOPMENT ONLY!"
  exit 1
end

class Seeder
  def self.run
    new.call
  end

  def initialize
    @user_id = User.last&.id.to_i + 1
    @property_id = Property.last&.id.to_i + 1
    @user_count = 0
    @users = []
    @publishers = []
    @properties = []
  end

  def call
    puts "[SEEDING DATABASE]: Started - This may take several minutes."
    seed_users
    seed_campaigns
    seed_properties
    ImpressionSeeder.run(ENV["MAX_IMPRESSIONS"].to_i)
    puts "[SEEDING DATABASE]: Completed"
  end

  private

  def seed_users
    @emails = User.all.pluck(:email).each_with_object({}) { |email, memo|
      memo[email] = true
    }
    csv_path = Rails.root.join("tmp", "users.csv")
    @users << build_administrator
    @users.concat build_advertisers
    @users.concat build_publishers
    csv_created = create_csv(@users, csv_path)
    import_csv("users", csv_path) if csv_created
  end

  def build_administrator
    admin_count = User.where("? = ANY (roles)", ENUMS::USER_ROLES::ADMINISTRATOR).count
    return unless admin_count.zero?
    return if @emails["admin@codefund.io"]
    puts "[SEEDING DATABASE]: Building administrator"
    @user_count += 1
    admin = user_attributes.merge(
      id: @user_id,
      company_name: "CodeFund",
      email: "admin@codefund.io",
      roles: "{#{ENUMS::USER_ROLES::ADMINISTRATOR}}",
    ).values
    @user_id += 1
    admin
  end

  def build_advertisers
    advertiser_count = User.where("? = ANY (roles)", ENUMS::USER_ROLES::ADVERTISER).count
    return [] if advertiser_count >= 100
    print "[SEEDING DATABASE]: Building advertisers "
    advertisers = (advertiser_count..99).map {
      @user_count += 1
      print "." if @user_count % 10 == 0
      advertiser = user_attributes.merge(id: @user_id, roles: "{#{ENUMS::USER_ROLES::ADVERTISER}}").values
      @user_id += 1
      advertiser
    }
    puts
    advertisers
  end

  def build_publishers
    publisher_count = User.where("? = ANY (roles)", ENUMS::USER_ROLES::PUBLISHER).count
    return [] if publisher_count >= 1000
    print "[SEEDING DATABASE]: Building publishers "
    publishers = (publisher_count..999).map {
      @user_count += 1
      print "." if @user_count % 10 == 0
      publisher = user_attributes.merge(id: @user_id, roles: "{#{ENUMS::USER_ROLES::PUBLISHER}}").values
      @publishers << @user_id
      @user_id += 1
      publisher
    }
    puts
    publishers
  end

  def seed_campaigns
    return if Campaign.count >= 1000
    print "[SEEDING DATABASE]: Seeding campaigns "
    User.where("? = ANY (roles)", ENUMS::USER_ROLES::ADVERTISER).each do |advertiser|
      print "."
      add_small_image(advertiser)
      add_large_image(advertiser)
      generate_creatives(advertiser)
      generate_campaigns(advertiser)
    end
    puts
  end

  def add_small_image(advertiser)
    advertiser.images.attach io: File.open(Rails.root.join("app/assets/images/seeds/code-fund-100x100.png")),
      filename: "code-fund-100x100.png",
      content_type: "image/png",
      metadata: {
        identified: true,
        width: 100,
        height: 100,
        analyzed: true,
        name: "CodeFund Small",
        format: ENUMS::IMAGE_FORMATS::SMALL,
      }
  end

  def add_large_image(advertiser)
    advertiser.images.attach io: File.open(Rails.root.join("app/assets/images/seeds/code-fund-260x200.png")),
      filename: "code-fund-100x100.png",
      content_type: "image/png",
      metadata: {
        identified: true,
        width: 260,
        height: 200,
        analyzed: true,
        name: "CodeFund Large",
        format: ENUMS::IMAGE_FORMATS::LARGE,
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

  def generate_campaigns(advertiser)
    10.times do
      start_date = rand(3).months.from_now.to_date
      end_date = start_date.advance(months: 6)
      total_budget = ([*500..5000].sample / 100) * 100
      daily_budget = total_budget / (end_date - start_date).to_i
      countries = ENUMS::DEVELOPED_MARKET_COUNTRIES.keys
      countries += ENUMS::EMERGING_MARKET_COUNTRIES.keys if rand(3).zero?
      countries += ENUMS::COUNTRIES.keys.sample(5) if rand(5).zero?
      keywords = ENUMS::KEYWORDS.values.sample(25)
      Campaign.create(
        user: advertiser,
        creative: advertiser.creatives.sample,
        status: ENUMS::CAMPAIGN_STATUSES.values.sample,
        name: Faker::SiliconValley.invention,
        url: Faker::SiliconValley.url,
        start_date: start_date,
        end_date: end_date,
        us_hours_only: rand(2).zero?,
        weekdays_only: rand(2).zero?,
        total_budget: total_budget,
        daily_budget: daily_budget,
        ecpm: 3,
        countries: countries,
        keywords: keywords,
        negative_keywords: ENUMS::KEYWORDS.values.sample(5) - keywords,
      )
    end
  end

  def seed_properties
    return if Property.count >= 10_000
    print "[SEEDING DATABASE]: Building properties"
    csv_path = Rails.root.join("tmp", "properties.csv")
    @publishers = User.where("? = ANY (roles)", ENUMS::USER_ROLES::PUBLISHER).pluck(:id) unless @publishers.present?
    @publishers.each do |publisher|
      print "."
      10.times do
        @properties << {
          id: @property_id,
          user_id: publisher,
          property_type: ENUMS::PROPERTY_TYPES.values.sample,
          status: ENUMS::PROPERTY_STATUSES.values.sample,
          name: Faker::SiliconValley.invention,
          description: nil,
          url: Faker::SiliconValley.url,
          ad_template: ENUMS::AD_TEMPLATES.values.sample,
          ad_theme: ENUMS::AD_THEMES.values.sample,
          language: ENUMS::LANGUAGES::ENGLISH,
          keywords: "{#{ENUMS::KEYWORDS.values.sample(25).join(",")}}",
          prohibited_advertisers: nil,
          prohibit_fallback_campaigns: false,
          created_at: Time.now,
          updated_at: Time.now,
        }.values
        @property_id += 1
      end
    end
    puts
    csv_created = create_csv(@properties, csv_path)
    import_csv("properties", csv_path) if csv_created
  end

  def create_csv(list, csv_path)
    return false unless list.compact.present?
    puts "Creating #{csv_path}"
    CSV.open(csv_path, "wb") do |csv|
      list.each do |record|
        csv << record
      end
    end
    true
  end

  def import_csv(table_name, csv_path)
    puts "Copying #{csv_path} to Postgres"
    ActiveRecord::Base.connection.execute "COPY \"#{table_name}\" FROM '#{csv_path}' CSV;"
    puts "Copy complete"
  rescue => e
    puts "Failed to copy #{csv_path} to Postgres! #{e}"
  ensure
    FileUtils.rm_f csv_path, verbose: true
  end

  def user_attributes
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = Faker::Internet.email("#{first_name} #{last_name}", "-")
    {
      id: 1,
      roles: [],
      first_name: first_name,
      last_name: last_name,
      company_name: Faker::SiliconValley.company,
      address_1: nil,
      address_2: nil,
      city: nil,
      region: nil,
      postal_code: nil,
      country: nil,
      api_access: true,
      api_key: nil,
      paypal_email: nil,
      email: email,
      encrypted_password: User.new(password: "secret").encrypted_password,
      reset_password_token: nil,
      reset_password_sent_at: nil,
      remember_created_at: nil,
      sign_in_count: 1,
      current_sign_in_at: nil,
      last_sign_in_at: nil,
      current_sign_in_ip: nil,
      last_sign_in_ip: nil,
      confirmation_token: Devise.friendly_token,
      confirmed_at: 1.day.ago,
      confirmation_sent_at: 2.days.ago,
      unconfirmed_email: nil,
      failed_attempts: 0,
      unlock_token: nil,
      locked_at: nil,
      created_at: 3.days.ago,
      updated_at: 3.days.ago,
    }
  end
end

Seeder.run
