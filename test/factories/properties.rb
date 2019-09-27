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
