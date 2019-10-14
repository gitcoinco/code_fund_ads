# == Schema Information
#
# Table name: campaigns
#
#  id                      :bigint           not null, primary key
#  user_id                 :bigint
#  creative_id             :bigint
#  status                  :string           not null
#  fallback                :boolean          default(FALSE), not null
#  name                    :string           not null
#  url                     :text             not null
#  start_date              :date
#  end_date                :date
#  core_hours_only         :boolean          default(FALSE)
#  weekdays_only           :boolean          default(FALSE)
#  total_budget_cents      :integer          default(0), not null
#  total_budget_currency   :string           default("USD"), not null
#  daily_budget_cents      :integer          default(0), not null
#  daily_budget_currency   :string           default("USD"), not null
#  ecpm_cents              :integer          default(0), not null
#  ecpm_currency           :string           default("USD"), not null
#  country_codes           :string           default([]), is an Array
#  keywords                :string           default([]), is an Array
#  negative_keywords       :string           default([]), is an Array
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  legacy_id               :uuid
#  organization_id         :bigint
#  job_posting             :boolean          default(FALSE), not null
#  province_codes          :string           default([]), is an Array
#  fixed_ecpm              :boolean          default(TRUE), not null
#  assigned_property_ids   :bigint           default([]), not null, is an Array
#  hourly_budget_cents     :integer          default(0), not null
#  hourly_budget_currency  :string           default("USD"), not null
#  prohibited_property_ids :bigint           default([]), not null, is an Array
#  creative_ids            :bigint           default([]), not null, is an Array
#  paid_fallback           :boolean          default(FALSE)
#

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
