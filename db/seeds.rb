# frozen_string_literal: true

require "faker"

unless Rails.env.development?
  puts "SEEDS ARE FOR DEVELOPMENT ONLY!"
  exit 1
end

def user_attributes
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email("#{first_name} #{last_name}", %w(. _ -))

  {
    first_name:             first_name,
    last_name:              last_name,
    email:                  email,
    company_name:           Faker::SiliconValley.company,
    confirmation_sent_at:   2.days.ago,
    confirmed_at:           1.day.ago,
    password:               "secret",
    password_confirmation:  "secret",
  }
end

def create_administrator
  attrs = user_attributes.merge(
    company_name: "CodeFund",
    email: "admin@codefund.io",
    roles: [ENUMS::USER_ROLES::ADMINISTRATOR],
  )
  administrator = User.find_or_initialize_by(email: attrs[:email])
  administrator.update_attributes!(attrs)
end

def create_publisher
  attrs = user_attributes.merge(roles: [ENUMS::USER_ROLES::PUBLISHER])
  publisher = User.find_or_initialize_by(email: attrs[:email])
  publisher.update_attributes!(attrs)
  generate_properties(publisher)
end

def create_advertiser
  attrs = user_attributes.merge(roles: [ENUMS::USER_ROLES::ADVERTISER])
  advertiser = User.find_or_initialize_by(email: attrs[:email])
  advertiser.update_attributes!(attrs)
  seed_campaigns(advertiser)
end

def seed_campaigns(advertiser)
  add_small_image(advertiser)
  add_large_image(advertiser)
  generate_creatives(advertiser)
  generate_campaigns(advertiser)
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
  (1..10).times do
    start_date = rand(3).months.from_now.to_date
    end_date = start_date.advance(months: 6)
    total_budget = ([*500..5000].sample / 100) * 100
    daily_budget = total_budget / (end_date - start_date).to_i
    countries = ENUMS::DEVELOPED_MARKET_COUNTRIES.keys
    countries = countries + ENUMS::EMERGING_MARKET_COUNTRIES.keys if rand(3).zero?
    countries = countries + ENUMS::COUNTRIES.keys.sample(5) if rand(5).zero?
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

def generate_properties(publisher)
  (1..10).times do
    Property.create(
      user: publisher,
      property_type: ENUMS::PROPERTY_TYPES.values.sample,
      status: ENUMS::PROPERTY_STATUSES.values.sample,
      name: Faker::SiliconValley.invention,
      url: Faker::SiliconValley.url,
      ad_template: ENUMS::AD_TEMPLATES.values.sample,
      ad_theme: ENUMS::AD_THEMES.values.sample,
      language: ENUMS::LANGUAGES::ENGLISH,
      keywords: ENUMS::KEYWORDS.values.sample(25),
    )
  end
end

create_administrator unless User.where("? = ANY (roles)", ENUMS::USER_ROLES::ADMINISTRATOR)
100.times { create_advertiser } unless User.where("? = ANY (roles)", ENUMS::USER_ROLES::ADVERTISER)
1000.times { create_publisher } unless User.where("? = ANY (roles)", ENUMS::USER_ROLES::PUBLISHER)

require_relative "./seeds_impressions" if ENV["IMPRESSIONS"]
