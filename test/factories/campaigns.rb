# == Schema Information
#
# Table name: campaigns
#
#  id                      :bigint           not null, primary key
#  assigned_property_ids   :bigint           default([]), not null, is an Array
#  audience_ids            :bigint           default([]), not null, is an Array
#  core_hours_only         :boolean          default(FALSE)
#  country_codes           :string           default([]), is an Array
#  creative_ids            :bigint           default([]), not null, is an Array
#  daily_budget_cents      :integer          default(0), not null
#  daily_budget_currency   :string           default("USD"), not null
#  ecpm_cents              :integer          default(0), not null
#  ecpm_currency           :string           default("USD"), not null
#  ecpm_multiplier         :decimal(, )      default(1.0), not null
#  end_date                :date             not null
#  fallback                :boolean          default(FALSE), not null
#  fixed_ecpm              :boolean          default(TRUE), not null
#  hourly_budget_cents     :integer          default(0), not null
#  hourly_budget_currency  :string           default("USD"), not null
#  job_posting             :boolean          default(FALSE), not null
#  keywords                :string           default([]), is an Array
#  name                    :string           not null
#  negative_keywords       :string           default([]), is an Array
#  paid_fallback           :boolean          default(FALSE)
#  prohibited_property_ids :bigint           default([]), not null, is an Array
#  province_codes          :string           default([]), is an Array
#  region_ids              :bigint           default([]), not null, is an Array
#  start_date              :date             not null
#  status                  :string           not null
#  total_budget_cents      :integer          default(0), not null
#  total_budget_currency   :string           default("USD"), not null
#  url                     :text             not null
#  weekdays_only           :boolean          default(FALSE)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  campaign_bundle_id      :bigint
#  creative_id             :bigint
#  legacy_id               :uuid
#  organization_id         :bigint
#  user_id                 :bigint
#
# Indexes
#
#  index_campaigns_on_assigned_property_ids    (assigned_property_ids) USING gin
#  index_campaigns_on_audience_ids             (audience_ids) USING gin
#  index_campaigns_on_campaign_bundle_id       (campaign_bundle_id)
#  index_campaigns_on_core_hours_only          (core_hours_only)
#  index_campaigns_on_country_codes            (country_codes) USING gin
#  index_campaigns_on_creative_id              (creative_id)
#  index_campaigns_on_creative_ids             (creative_ids) USING gin
#  index_campaigns_on_end_date                 (end_date)
#  index_campaigns_on_job_posting              (job_posting)
#  index_campaigns_on_keywords                 (keywords) USING gin
#  index_campaigns_on_name                     (lower((name)::text))
#  index_campaigns_on_negative_keywords        (negative_keywords) USING gin
#  index_campaigns_on_organization_id          (organization_id)
#  index_campaigns_on_paid_fallback            (paid_fallback)
#  index_campaigns_on_prohibited_property_ids  (prohibited_property_ids) USING gin
#  index_campaigns_on_province_codes           (province_codes) USING gin
#  index_campaigns_on_region_ids               (region_ids) USING gin
#  index_campaigns_on_start_date               (start_date)
#  index_campaigns_on_status                   (status)
#  index_campaigns_on_user_id                  (user_id)
#  index_campaigns_on_weekdays_only            (weekdays_only)
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
