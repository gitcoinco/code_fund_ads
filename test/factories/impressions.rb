require "factory_bot_rails"
require "faker"

FactoryBot.define do
  factory :impression do
    association :campaign
    association :property

    id { SecureRandom.uuid }
    ad_template { "default" }
    ad_theme { "light" }
    ip_address { rand(6).zero? ? Faker::Internet.ip_v6_address : Faker::Internet.pubplic_ip_v4_address }
    user_agent { Faker::Internet.user_agent }
    country_code { rand(6).zero? ? "US" : Country.all.sample.iso_code }
    clicked_at { rand(100) <= 3 ? displayed_at : nil }
    fallback_campaign { campaign.fallback }

    after :build do |impression|
      impression.advertiser_id = campaign.user.id
      impression.publisher_id = property.user.id
      impression.organization_id = campaign.user.organization.id
      impression.creative_id = campaign.creative.ids.sample
    end

    # after :create do |impression|
    #   impression.displayed_at
    #   impression.displayed_at_date
    # end
  end
end
