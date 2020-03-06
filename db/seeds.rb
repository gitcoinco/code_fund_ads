# frozen_string_literal: true

require_relative "./impression_seeder"

ActionMailer::Base.perform_deliveries = false

unless Rails.env.development? || ENV["ALLOW_SEED"] == true
  puts "Seeds are for development only."
  exit 1
end

def Organization.default_bulk_columns
  column_names
end

def random_name(prefix)
  "#{prefix}-#{SecureRandom.hex.upcase[0, 8]}"
end

# CODEFUND ...................................................................................................
puts "Seeding CodeFund organization and users"
codefund = Organization.where(id: 1).first_or_create!(name: random_name("CodeFund"), creative_approval_needed: false)
admin = User.where(id: 1, organization: codefund).first_or_initialize(
  email: "admin@codefund.io",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  confirmed_at: Time.current,
  roles: [ENUMS::USER_ROLES::ADMINISTRATOR]
)
admin.password = admin.password_confirmation = "secret"
admin.save!
User.connection.exec_query "ALTER SEQUENCE users_id_seq RESTART WITH #{User.maximum(:id) + 1}"

# PUBLISHERS .................................................................................................
unless User.publishers.exists?
  puts "Seeding publishers"
  publishers = 250.times.map {
    {
      email: "#{random_name "user"}@codefund.io",
      encrypted_password: admin.encrypted_password,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      roles: [ENUMS::USER_ROLES::PUBLISHER],
      confirmed_at: Time.current,
      created_at: Time.current,
      updated_at: Time.current
    }
  }
  User.insert_all publishers
end

# PROPERTIES .................................................................................................
unless Property.exists?
  puts "Seeding properties"
  properties = User.publishers.map { |publisher|
    audience = [Audience.javascript_and_frontend, Audience.web_development_and_backend, Audience.blockchain].sample
    {
      user_id: publisher.id,
      property_type: ENUMS::PROPERTY_TYPES::WEBSITE,
      audience_id: audience.id,
      keywords: audience.keywords,
      status: ENUMS::PROPERTY_STATUSES::ACTIVE,
      name: random_name("Property"),
      url: Faker::Internet.url(scheme: "https"),
      language: ENUMS::LANGUAGES::ENGLISH,
      revenue_percentage: 0.7,
      ad_template: ENUMS::AD_TEMPLATES::DEFAULT,
      ad_theme: ENUMS::AD_THEMES::LIGHT,
      created_at: Time.current,
      updated_at: Time.current
    }
  }
  Property.insert_all properties
end

# ADVERTISERS ................................................................................................
unless User.advertisers.exists?
  puts "Seeding organizations and advertisers"
  Organization.insert_all 30.times.map { |index|
    {
      id: index + 2,
      name: random_name(Faker::Company.name),
      balance_cents: rand(0..500000),
      created_at: Time.current,
      updated_at: Time.current
    }
  }
  Organization.connection.exec_query "ALTER SEQUENCE organizations_id_seq RESTART WITH #{Organization.maximum(:id) + 1}"
  advertisers = Organization.where.not(id: 1).pluck(:id).map { |organization_id|
    {
      organization_id: organization_id,
      email: "#{random_name "user"}@codefund.io",
      encrypted_password: admin.encrypted_password,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      roles: [ENUMS::USER_ROLES::ADVERTISER],
      created_at: Time.current,
      updated_at: Time.current
    }
  }
  User.insert_all advertisers
end

# CREATIVES ..................................................................................................
unless Creative.exists?
  puts "Seeding creatives"
  creatives = []
  User.advertisers.each do |advertiser|
    creatives.concat(
      5.times.map {
        {
          organization_id: advertiser.organization_id,
          user_id: advertiser.id,
          name: random_name("Creative"),
          cta: random_name("CTA"),
          headline: random_name("Headline"),
          body: "This is a premium campaign",
          status: ENUMS::CREATIVE_STATUSES::ACTIVE,
          created_at: Time.current,
          updated_at: Time.current
        }
      }
    )
  end
  Creative.insert_all creatives
end

# CAMPAIGN BUNDLES ...........................................................................................
unless CampaignBundle.exists?
  puts "Seeding campaign bundles"
  campaign_bundles = User.advertisers.map { |advertiser|
    regions = [
      [Region.asia_eastern, Region.asia_southern_and_western],
      [Region.europe, Region.europe_eastern, Region.australia_and_new_zealand],
      [Region.americas_northern, Region.americas_central_southern],
      [Region.americas_northern]
    ].sample
    start_date = rand(1..12).months.ago
    {
      organization_id: advertiser.organization_id,
      user_id: advertiser.id,
      name: random_name("CampaignBundle"),
      start_date: start_date.to_date,
      end_date: start_date.advance(months: 2).to_date,
      region_ids: regions.map(&:id),
      created_at: Time.current,
      updated_at: Time.current
    }
  }
  CampaignBundle.insert_all campaign_bundles
end

# CAMPAIGNS ..................................................................................................
unless Campaign.exists?
  puts "Seeding campaigns"
  campaigns = CampaignBundle.includes(:user).map { |campaign_bundle|
    creative_ids = campaign_bundle.user.creatives.sample(3).map(&:id)
    total_budget_cents = rand(50000...250000)
    audiences = [
      [Audience.blockchain],
      [Audience.javascript_and_frontend, Audience.web_development_and_backend],
      [Audience.javascript_and_frontend]
    ].sample
    {
      campaign_bundle_id: campaign_bundle.id,
      start_date: campaign_bundle.start_date,
      end_date: campaign_bundle.end_date,
      organization_id: campaign_bundle.organization_id,
      user_id: campaign_bundle.user_id,
      creative_id: creative_ids.first,
      creative_ids: creative_ids,
      status: ENUMS::CAMPAIGN_STATUSES::ACTIVE,
      name: random_name("Campaign"),
      url: Faker::Internet.url(scheme: "https"),
      total_budget_cents: total_budget_cents,
      daily_budget_cents: (total_budget_cents / 90.to_f).round,
      hourly_budget_cents: (total_budget_cents / 720.to_f).round,
      audience_ids: audiences.map(&:id),
      keywords: audiences.map(&:keywords).flatten,
      region_ids: campaign_bundle.regions.map(&:id),
      country_codes: campaign_bundle.regions.map(&:country_codes).flatten,
      created_at: Time.current,
      updated_at: Time.current
    }
  }
  Campaign.insert_all campaigns
end

ImpressionSeeder.run

puts "Seeding complete"
puts "--------------------"
puts "Administrators: #{User.administrators.count}"
puts "Publishers: #{User.publishers.count}"
puts "Properties: #{Property.count}"
puts "Organizations: #{Organization.count}"
puts "Advertisers: #{User.advertisers.count}"
puts "Creatives: #{Creative.count}"
puts "Campaigns: #{Campaign.count}"
sleep 10
puts "Impressions: #{Impression.count}"
