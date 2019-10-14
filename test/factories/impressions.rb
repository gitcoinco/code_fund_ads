# == Schema Information
#
# Table name: impressions
#
#  id                                          :uuid             not null, primary key
#  advertiser_id                               :bigint           not null
#  publisher_id                                :bigint           not null
#  campaign_id                                 :bigint           not null
#  creative_id                                 :bigint           not null
#  property_id                                 :bigint           not null
#  ip_address                                  :string           not null
#  user_agent                                  :text             not null
#  country_code                                :string
#  postal_code                                 :string
#  latitude                                    :decimal(, )
#  longitude                                   :decimal(, )
#  displayed_at                                :datetime         not null
#  displayed_at_date                           :date             not null
#  clicked_at                                  :datetime
#  clicked_at_date                             :date
#  fallback_campaign                           :boolean          default(FALSE), not null
#  estimated_gross_revenue_fractional_cents    :float
#  estimated_property_revenue_fractional_cents :float
#  estimated_house_revenue_fractional_cents    :float
#  ad_template                                 :string
#  ad_theme                                    :string
#  organization_id                             :bigint
#  uplift                                      :boolean          default(FALSE)
#  province_code                               :string
#

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
