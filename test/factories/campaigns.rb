require "factory_bot_rails"
require "faker"

FactoryBot.define do
  date = Date.current.beginning_of_month.advance(months: 12 * -1)

  factory :campaign do
    association :user, factory: :advertiser

    status { ENUMS::CAMPAIGN_STATUSES.values.sample }
    name { Faker::Company.name }
    url { Faker::TvShows::SiliconValley.url }
    start_date { date.advance(months: rand(0..11)) }
    end_date { start_date.advance(months: rand(2..3)) }
    total_budget_cents { ([*500..5000].sample / 100) * 100 }
    daily_budget_cents { total_budget_cents / (end_date - start_date).to_i }
    ecpm_cents { rand(1..3) }
    keywords { ENUMS::KEYWORDS.keys.sample(25) }
    negative_keywords { (ENUMS::KEYWORDS.keys.sample(2) - keywords) }

    after :build do |campaign|
      campaign.creative_id = campaign.user.creatives.ids.sample
      campaign.country_codes = ["US", "CA"]
      campaign.country_codes += ["BR", "IN"] if rand(3).zero?
      campaign.country_codes += Country.all.sample(5).map(&:iso_code) if rand(5).zero?
    end

    trait :status_active do
      status { "active" }
    end
  end
end
