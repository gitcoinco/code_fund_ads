require "factory_bot_rails"
require "faker"

FactoryBot.define do
  factory :impression do
    association :campaign
    association :property

    id { SecureRandom.uuid }
    ad_template { "default" }
    ad_theme { "light" }
    ip_address { rand(6).zero? ? Faker::Internet.ip_v6_address : Faker::Internet.public_ip_v4_address }
    user_agent { Faker::Internet.user_agent }
    country_code { rand(6).zero? ? "US" : Country.all.sample.iso_code }
    fallback_campaign { campaign.fallback }

    after :build do |impression|
      impression.advertiser_id = impression.campaign.user.id
      impression.publisher_id = impression.property.user.id
      impression.organization_id = impression.campaign.user.organization.id
      impression.creative_id = impression.campaign.creatives.ids.sample
      impression.displayed_at_date = impression.displayed_at.to_date
      impression.clicked_at = rand(1000) <= 4 ? impression.displayed_at : nil
      impression.obfuscate_ip_address
      impression.assure_partition_table!
    end
  end
end
