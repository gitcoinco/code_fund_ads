# == Schema Information
#
# Table name: properties
#
#  id                             :bigint           not null, primary key
#  ad_template                    :string
#  ad_theme                       :string
#  assigned_fallback_campaign_ids :bigint           default([]), not null, is an Array
#  deleted_at                     :datetime
#  description                    :text
#  fallback_ad_template           :string
#  fallback_ad_theme              :string
#  keywords                       :string           default([]), not null, is an Array
#  language                       :string           not null
#  name                           :string           not null
#  prohibit_fallback_campaigns    :boolean          default(FALSE), not null
#  prohibited_advertiser_ids      :bigint           default([]), not null, is an Array
#  property_type                  :string           not null
#  responsive_behavior            :string           default("none"), not null
#  restrict_to_assigner_campaigns :boolean          default(FALSE), not null
#  revenue_percentage             :decimal(, )      default(0.6), not null
#  status                         :string           not null
#  url                            :text             not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  audience_id                    :bigint
#  legacy_id                      :uuid
#  user_id                        :bigint           not null
#
# Indexes
#
#  index_properties_on_assigned_fallback_campaign_ids  (assigned_fallback_campaign_ids) USING gin
#  index_properties_on_audience_id                     (audience_id)
#  index_properties_on_deleted_at                      (deleted_at)
#  index_properties_on_keywords                        (keywords) USING gin
#  index_properties_on_name                            (lower((name)::text))
#  index_properties_on_prohibited_advertiser_ids       (prohibited_advertiser_ids) USING gin
#  index_properties_on_property_type                   (property_type)
#  index_properties_on_status                          (status)
#  index_properties_on_user_id                         (user_id)
#

require "factory_bot_rails"
require "faker"

FactoryBot.define do
  factory :property do
    association :user, factory: :publisher

    property_type { ENUMS::PROPERTY_TYPES.values.sample }
    status { rand(5).zero? ? ENUMS::PROPERTY_STATUSES.values.sample : ENUMS::PROPERTY_STATUSES::ACTIVE }
    name { Faker::TvShows::SiliconValley.invention }
    url { Faker::TvShows::SiliconValley.url }
    ad_template { ENUMS::AD_TEMPLATES.values.sample }
    ad_theme { ENUMS::AD_THEMES.values.sample }
    language { ENUMS::LANGUAGES::ENGLISH }
    keywords { ENUMS::KEYWORDS.keys.sample(25) }
  end
end
