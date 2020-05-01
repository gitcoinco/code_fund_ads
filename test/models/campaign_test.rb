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

require "test_helper"

class CampaignTest < ActiveSupport::TestCase
  setup do
    @campaign = campaigns(:premium)
    @campaign.start_date = Date.parse("2019-01-01")
    @campaign.end_date = @campaign.start_date.advance(months: 3)
    @campaign.organization.update balance: Monetize.parse("$10,000 USD")
    travel_to @campaign.start_date.to_time.advance(days: 15)
  end

  teardown do
    travel_back
  end

  test "pricing strategy without bundle" do
    assert @campaign.campaign_pricing_strategy?
  end

  test "pricing strategy with bundle" do
    @campaign.update campaign_bundle: campaign_bundles(:default)
    assert @campaign.region_and_audience_pricing_strategy?
  end

  test "fixed_ecpm? without bundle" do
    @campaign.update fixed_ecpm: true
    assert @campaign.fixed_ecpm?
    @campaign.update fixed_ecpm: false
    refute @campaign.fixed_ecpm?
  end

  test "fixed_ecpm? with bundle" do
    @campaign.update campaign_bundle: campaign_bundles(:default)
    @campaign.update fixed_ecpm: true
    refute @campaign.fixed_ecpm?
  end

  test "campaigns can only be paused if already active" do
    @campaign.update status: ENUMS::CAMPAIGN_STATUSES::PENDING
    refute AuthorizedUser.new(@campaign.user).can_pause_campaign?(@campaign)
  end

  test "campaigns can be paused if already active" do
    @campaign.update status: ENUMS::CAMPAIGN_STATUSES::ACTIVE
    assert AuthorizedUser.new(@campaign.user).can_pause_campaign?(@campaign)
  end

  test "campaigns can't be paused by an unauthorized user" do
    user = users(:publisher)
    @campaign.update status: ENUMS::CAMPAIGN_STATUSES::ACTIVE
    @campaign.organization.organization_users.where(user: user).destroy_all
    refute @campaign.organization.users.include?(user)
    refute AuthorizedUser.new(user).can_pause_campaign?(@campaign)
  end

  test "campaigns can be activated by admins" do
    @campaign.update status: ENUMS::CAMPAIGN_STATUSES::ACCEPTED
    refute AuthorizedUser.new(@campaign.user).can_activate_campaign?(@campaign)
    assert AuthorizedUser.new(users(:administrator)).can_activate_campaign?(@campaign)

    @campaign.update status: ENUMS::CAMPAIGN_STATUSES::PENDING
    refute AuthorizedUser.new(@campaign.user).can_activate_campaign?(@campaign)
    assert AuthorizedUser.new(users(:administrator)).can_activate_campaign?(@campaign)
  end

  test "paused campaigns can be activated by organization managers" do
    user = users(:publisher)
    @campaign.update status: ENUMS::CAMPAIGN_STATUSES::PAUSED
    @campaign.organization.organization_users.where(user: user).destroy_all
    assert AuthorizedUser.new(@campaign.user).can_activate_campaign?(@campaign)
    assert AuthorizedUser.new(users(:administrator)).can_activate_campaign?(@campaign)
    refute AuthorizedUser.new(user).can_activate_campaign?(@campaign)
  end

  test "initial campaign budgets" do
    assert @campaign.total_budget == Monetize.parse("$5,000.00 USD")
    assert @campaign.ecpm == Monetize.parse("$3.00 USD")
    assert @campaign.total_consumed_budget == Monetize.parse("$0.00 USD")
    assert @campaign.total_remaining_budget == @campaign.total_budget
    assert @campaign.total_operative_days == 91
  end

  test "restricting to weekdays impacts the numbers" do
    @campaign.update weekdays_only: true
    assert @campaign.total_operative_days == 65
  end

  test "increasing ecpm up impacts the numbers" do
    @campaign.update ecpm: Monetize.parse("$4.00 USD")
  end

  test "decreasing ecpm down impacts the numbers" do
    @campaign.update ecpm: Monetize.parse("$2.00 USD")
  end

  test "increasing total_budget impacts the numbers" do
    @campaign.update total_budget: Monetize.parse("$8,000.00 USD")
  end

  test "decreasing daily_budget yields a budget surplus" do
    @campaign.update daily_budget: Monetize.parse("$20.00 USD")
  end

  test "ecpms fixed" do
    @campaign.fixed_ecpm = true
    assert @campaign.ecpm == Monetize.parse("$3.00 USD")
    assert @campaign.ecpms.sort_by { |row| row[:country_iso_code] } == [
      {country_iso_code: "CA", country_name: "Canada", ecpm: Monetize.parse("$3.00 USD")},
      {country_iso_code: "FR", country_name: "France", ecpm: Monetize.parse("$3.00 USD")},
      {country_iso_code: "GB", country_name: "United Kingdom of Great Britain and Northern Ireland", ecpm: Monetize.parse("$3.00 USD")},
      {country_iso_code: "IN", country_name: "India", ecpm: Monetize.parse("$3.00 USD")},
      {country_iso_code: "JP", country_name: "Japan", ecpm: Monetize.parse("$3.00 USD")},
      {country_iso_code: "RO", country_name: "Romania", ecpm: Monetize.parse("$3.00 USD")},
      {country_iso_code: "US", country_name: "United States of America", ecpm: Monetize.parse("$3.00 USD")}
    ]
  end

  test "ecpms old pricing based on start_date before 2019-03-07" do
    @campaign.fixed_ecpm = false
    @campaign.start_date = Date.parse("2019-03-06")
    @campaign.end_date = @campaign.start_date.advance(months: 1)
    assert @campaign.ecpm == Monetize.parse("$3.00 USD")

    assert @campaign.ecpms.sort_by { |row| row[:country_iso_code] } == [
      {country_iso_code: "CA", country_name: "Canada", ecpm: Monetize.parse("$2.13 USD")},
      {country_iso_code: "FR", country_name: "France", ecpm: Monetize.parse("$1.08 USD")},
      {country_iso_code: "GB", country_name: "United Kingdom of Great Britain and Northern Ireland", ecpm: Monetize.parse("$2.61 USD")},
      {country_iso_code: "IN", country_name: "India", ecpm: Monetize.parse("$0.69 USD")},
      {country_iso_code: "JP", country_name: "Japan", ecpm: Monetize.parse("$1.59 USD")},
      {country_iso_code: "RO", country_name: "Romania", ecpm: Monetize.parse("$0.93 USD")},
      {country_iso_code: "US", country_name: "United States of America", ecpm: Monetize.parse("$3.00 USD")}
    ]
  end

  test "ecpms new pricing based on start_date after 2019-03-07" do
    @campaign.fixed_ecpm = false
    @campaign.start_date = Date.parse("2019-03-07")
    @campaign.end_date = @campaign.start_date.advance(months: 1)
    assert @campaign.ecpm == Monetize.parse("$3.00 USD")
    assert @campaign.ecpms.sort_by { |row| row[:country_iso_code] } == [
      {country_iso_code: "CA", country_name: "Canada", ecpm: Monetize.parse("$3.00 USD")},
      {country_iso_code: "FR", country_name: "France", ecpm: Monetize.parse("$2.40 USD")},
      {country_iso_code: "GB", country_name: "United Kingdom of Great Britain and Northern Ireland", ecpm: Monetize.parse("$2.40 USD")},
      {country_iso_code: "IN", country_name: "India", ecpm: Monetize.parse("$0.30 USD")},
      {country_iso_code: "JP", country_name: "Japan", ecpm: Monetize.parse("$0.30 USD")},
      {country_iso_code: "RO", country_name: "Romania", ecpm: Monetize.parse("$0.90 USD")},
      {country_iso_code: "US", country_name: "United States of America", ecpm: Monetize.parse("$3.00 USD")}
    ]
  end

  test "standard campaign doesn't have a selling_price" do
    assert @campaign.selling_price.nil?
  end

  test "url's have whitespace stripped prior to saving" do
    assert @campaign.update(url: " https://app.codefund.io")
    assert_equal "https://app.codefund.io", @campaign.url
  end

  test "URI must be valid in order to be saved" do
    assert_not @campaign.update(url: "<E2><80><8B>https://app.codefund.io")
    assert_equal ["is invalid"], @campaign.errors.messages[:url]
  end

  test "creatives must be active for active campaign" do
    @campaign.stubs(active?: true)
    @campaign.creatives.update status: :pending
    assert_not @campaign.valid?
    assert_equal ["cannot be inactive"], @campaign.errors.messages[:creatives]
  end

  test "creatives may be innactive for innactive campaign" do
    @campaign.stubs(active?: false)
    @campaign.creatives.sample.update(status: :pending)
    assert @campaign.valid?
  end

  test "cannot be destroyed if there are associated daily summaries" do
    DailySummary.create impressionable_type: "Campaign",
                        impressionable_id: @campaign.id,
                        displayed_at_date: Date.today
    assert_not @campaign.destroy
    assert_includes @campaign.errors.messages[:base].to_s, "has associated"
  end

  test "cannot be destroyed if there are associated impressions" do
    premium_impression campaign: @campaign,
                       estimated_gross_revenue_fractional_cents: @campaign.daily_budget.cents,
                       displayed_at: Time.current,
                       displayed_at_date: Date.current
    assert_not @campaign.destroy
    assert_includes @campaign.errors.messages[:base].to_s, "has associated"
  end

  test "bundled start and end date changes will update bundle" do
    bundled_campaign = campaigns(:premium_bundled)
    start_date = Date.parse("2020-03-01 01:00:00 UTC")
    end_date = Date.parse("2020-06-04 01:00:00 UTC")

    assert_equal bundled_campaign.campaign_bundle.start_date, bundled_campaign.start_date
    assert_equal bundled_campaign.campaign_bundle.end_date, bundled_campaign.end_date
    bundled_campaign.update! start_date: start_date, end_date: end_date
    assert bundled_campaign.start_date == start_date
    assert bundled_campaign.end_date == end_date
    assert_equal bundled_campaign.start_date, bundled_campaign.campaign_bundle.start_date
    assert_equal bundled_campaign.end_date, bundled_campaign.campaign_bundle.end_date
  end
end
