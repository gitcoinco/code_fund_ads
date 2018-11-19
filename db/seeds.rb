require "faker"

unless Rails.env.development?
  puts "SEEDS ARE FOR DEVELOPMENT ONLY!"
  exit 1
end

user_attributes = {
  company_name: "CodeFund",
  confirmation_sent_at: 2.days.ago,
  confirmed_at: 1.day.ago,
  password: "secret",
  password_confirmation: "secret",
}

administrator = User.find_or_initialize_by(email: "chris.knight@codefund.io")
administrator.assign_attributes(
  user_attributes.merge(
    roles: [ENUMS::USER_ROLES::ADMINISTRATOR],
    first_name: "Chris",
    last_name: "Knight",
  )
)
administrator.save!

publisher = User.find_or_initialize_by(email: "mitch.taylor@codefund.io")
publisher.assign_attributes(
  user_attributes.merge(
    roles: [ENUMS::USER_ROLES::PUBLISHER],
    first_name: "Mitch",
    last_name: "Taylor",
  )
)
publisher.save!

advertiser = User.find_or_initialize_by(email: "jordan.cochran@codefund.io")
advertiser.assign_attributes(
  user_attributes.merge(
    roles: [ENUMS::USER_ROLES::ADVERTISER],
    first_name: "Jordan",
    last_name: "Cochran",
  )
)
advertiser.save!

if advertiser.images.search_metadata_name("CodeFund Small").search_metadata_format(ENUMS::IMAGE_FORMATS::SMALL).count == 0
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

if advertiser.images.search_metadata_name("CodeFund Large").search_metadata_format(ENUMS::IMAGE_FORMATS::LARGE).count == 0
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

if advertiser.creatives.count == 0
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

if advertiser.campaigns.count == 0
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

if publisher.properties.count == 0
  10.times do
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

require_relative "./seeds_impressions" if ENV["IMPRESSIONS"]
