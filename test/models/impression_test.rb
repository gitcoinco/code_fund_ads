# == Schema Information
#
# Table name: impressions
#
#  id                                          :uuid             not null, primary key
#  ad_template                                 :string
#  ad_theme                                    :string
#  clicked_at                                  :datetime
#  clicked_at_date                             :date
#  country_code                                :string
#  displayed_at                                :datetime         not null
#  displayed_at_date                           :date             not null
#  estimated_gross_revenue_fractional_cents    :float
#  estimated_house_revenue_fractional_cents    :float
#  estimated_property_revenue_fractional_cents :float
#  fallback_campaign                           :boolean          default(FALSE), not null
#  ip_address                                  :string           not null
#  latitude                                    :decimal(, )
#  longitude                                   :decimal(, )
#  postal_code                                 :string
#  province_code                               :string
#  uplift                                      :boolean          default(FALSE)
#  user_agent                                  :text             not null
#  advertiser_id                               :bigint           not null
#  campaign_id                                 :bigint           not null
#  creative_id                                 :bigint           not null
#  organization_id                             :bigint
#  property_id                                 :bigint           not null
#  publisher_id                                :bigint           not null
#
# Indexes
#
#  index_impressions_on_ad_template                                 (ad_template)
#  index_impressions_on_ad_theme                                    (ad_theme)
#  index_impressions_on_advertiser_id                               (advertiser_id)
#  index_impressions_on_campaign_id                                 (campaign_id)
#  index_impressions_on_clicked_at_date                             (clicked_at_date)
#  index_impressions_on_clicked_at_hour                             (date_trunc('hour'::text, clicked_at))
#  index_impressions_on_country_code                                (country_code)
#  index_impressions_on_creative_id                                 (creative_id)
#  index_impressions_on_displayed_at_date                           (displayed_at_date)
#  index_impressions_on_displayed_at_hour                           (date_trunc('hour'::text, displayed_at))
#  index_impressions_on_id_and_advertiser_id_and_displayed_at_date  (id,advertiser_id,displayed_at_date) UNIQUE
#  index_impressions_on_organization_id                             (organization_id)
#  index_impressions_on_property_id                                 (property_id)
#  index_impressions_on_province_code                               (province_code)
#  index_impressions_on_uplift                                      (uplift)
#

require "test_helper"

class ImpressionTest < ActiveSupport::TestCase
  setup do
    @property = properties(:website)
    @campaign = amend(campaigns: :premium, start_date: 1.month.ago.to_date, end_date: 1.month.from_now.to_date)
  end

  test "US applicable_ecpm without region_ids" do
    @campaign.update fixed_ecpm: false, region_ids: []
    impression = create_impression(@property, @campaign)
    assert impression.country_code == "US"
    assert impression.campaign.ecpm == Monetize.parse("$3.00 USD")
    assert impression.applicable_ecpm == Monetize.parse("$3.00 USD")
  end

  test "JP applicable_ecpm without region_ids" do
    @campaign.update fixed_ecpm: false, region_ids: []
    impression = create_impression(@property, @campaign, country_code: "JP")
    assert impression.campaign.ecpm == Monetize.parse("$3.00 USD")
    assert impression.applicable_ecpm == Monetize.parse("$0.30 USD")
  end

  test "US + CSS & Design applicable_ecpm with bundle and region_ids" do
    @property.update audience: Audience.css_and_design
    @campaign.update campaign_bundle: amend(campaign_bundles: :default, region_ids: [Region.americas_northern.id, Region.asia_southern_and_western.id])
    impression = create_impression(@property, @campaign)
    assert impression.country_code == "US"
    assert impression.applicable_ecpm == Monetize.parse("$3.75 USD")
  end

  test "US + CSS & Design applicable_ecpm with bundle, region_ids, and multiplier" do
    @property.update audience: Audience.css_and_design
    @campaign.update ecpm_multiplier: 0.85, campaign_bundle: amend(campaign_bundles: :default, region_ids: [Region.americas_northern.id, Region.asia_southern_and_western.id])
    impression = create_impression(@property, @campaign)
    assert impression.country_code == "US"
    assert impression.applicable_ecpm == Monetize.parse("$3.19 USD")
  end

  test "IN + JavaScript applicable_ecpm with bundle and region_ids" do
    @property.update audience: Audience.css_and_design
    @campaign.update campaign_bundle: amend(campaign_bundles: :default, region_ids: [Region.americas_northern.id, Region.asia_southern_and_western.id])
    impression = create_impression(@property, @campaign, country_code: "IN")
    assert impression.applicable_ecpm == Monetize.parse("$1.13 USD")
  end

  test "IN + JavaScript applicable_ecpm with bundle, region_ids, and multiplier" do
    @property.update audience: Audience.css_and_design
    @campaign.update ecpm_multiplier: 1.35, campaign_bundle: amend(campaign_bundles: :default, region_ids: [Region.americas_northern.id, Region.asia_southern_and_western.id])
    impression = create_impression(@property, @campaign, country_code: "IN")
    assert impression.applicable_ecpm == Monetize.parse("$1.53 USD")
  end

  test "calculated revenue with fixed ecpm campaign and unknown country" do
    @property.update revenue_percentage: 0.65
    @campaign.update fixed_ecpm: true, ecpm: Monetize.parse("$3.00 USD")
    impression = create_impression(@property, @campaign, country_code: nil)
    assert impression.applicable_ecpm == Monetize.parse("$3.00 USD")
    assert impression.calculate_estimated_gross_revenue_fractional_cents == 0.3
    assert impression.calculate_estimated_property_revenue_fractional_cents == 0.195
    assert impression.calculate_estimated_house_revenue_fractional_cents == 0.105
    assert impression.calculate_estimated_property_revenue_fractional_cents + impression.calculate_estimated_house_revenue_fractional_cents == impression.calculate_estimated_gross_revenue_fractional_cents
  end

  test "calculated revenue with unknown country" do
    @property.update revenue_percentage: 0.65
    @campaign.update fixed_ecpm: false, ecpm: Monetize.parse("$3.00 USD")
    impression = create_impression(@property, @campaign, country_code: nil, province_code: nil, postal_code: nil)
    assert impression.applicable_ecpm == Monetize.parse("$0.15 USD")
    assert impression.calculate_estimated_gross_revenue_fractional_cents == 0.015
    assert impression.calculate_estimated_property_revenue_fractional_cents == 0.00975
    assert impression.calculate_estimated_house_revenue_fractional_cents == 0.00525
    assert impression.calculate_estimated_property_revenue_fractional_cents + impression.calculate_estimated_house_revenue_fractional_cents == impression.calculate_estimated_gross_revenue_fractional_cents
  end

  test "calculated revenue with fixed ecpm campaign and known country" do
    @property.update revenue_percentage: 0.65
    @campaign.update fixed_ecpm: true, ecpm: Monetize.parse("$3.00 USD")
    impression = create_impression(@property, @campaign, country_code: "RO")
    assert impression.applicable_ecpm == Monetize.parse("$3.00 USD")
    assert impression.calculate_estimated_gross_revenue_fractional_cents == 0.3
    assert impression.calculate_estimated_property_revenue_fractional_cents == 0.195
    assert impression.calculate_estimated_house_revenue_fractional_cents == 0.105
    assert impression.calculate_estimated_property_revenue_fractional_cents + impression.calculate_estimated_house_revenue_fractional_cents == impression.calculate_estimated_gross_revenue_fractional_cents
  end

  test "calculated revenue with known country" do
    @property.update revenue_percentage: 0.7
    @campaign.update fixed_ecpm: false, ecpm: Monetize.parse("$4.50 USD"), start_date: "2019-03-07", end_date: "2019-05-01"
    impression = create_impression(@property, @campaign, country_code: "BB")
    assert impression.applicable_ecpm == Monetize.parse("$3.02 USD")
    assert impression.calculate_estimated_gross_revenue_fractional_cents == 0.302
    assert impression.calculate_estimated_property_revenue_fractional_cents == 0.2114
    assert impression.calculate_estimated_house_revenue_fractional_cents == 0.0906
    assert impression.calculate_estimated_property_revenue_fractional_cents + impression.calculate_estimated_house_revenue_fractional_cents == impression.calculate_estimated_gross_revenue_fractional_cents
  end

  test "calculated revenue with known country and old pricing based on campaign start date before 2019-03-07" do
    @property.update revenue_percentage: 0.7
    @campaign.update fixed_ecpm: false, ecpm: Monetize.parse("$4.50 USD"), start_date: "2019-03-06", end_date: "2019-05-01"
    impression = create_impression(@property, @campaign, country_code: "BB")
    assert impression.applicable_ecpm == Monetize.parse("$0.22 USD")
    assert impression.calculate_estimated_gross_revenue_fractional_cents == 0.022
    assert impression.calculate_estimated_property_revenue_fractional_cents == 0.0154
    assert impression.calculate_estimated_house_revenue_fractional_cents == 0.0066
    assert impression.calculate_estimated_property_revenue_fractional_cents + impression.calculate_estimated_house_revenue_fractional_cents == impression.calculate_estimated_gross_revenue_fractional_cents
  end

  test "obfuscate_ip_address" do
    orig_salt = ENV["IP_ADDRESS_SALT"]
    ENV["IP_ADDRESS_SALT"] = "ace90a0841b3b5cb9e4f1ae8c5a8095421c2c7adaa86dbfa1bff35b812f16954b8a06bcb7f2608045ee1789550e39e8c1c660cdffaf13afbe857595f5e870447"
    obfuscated_ip = Impression.obfuscate_ip_address("127.0.0.1")
    assert obfuscated_ip == "598268db9860a90bef29e4e6c03aa09a"
    assert Impression.obfuscate_ip_address(obfuscated_ip) == "598268db9860a90bef29e4e6c03aa09a"
  ensure
    ENV["IP_ADDRESS_SALT"] = orig_salt
  end

  private

  def create_impression(property, campaign, attributes = {})
    campaign.impressions.create!({
      advertiser: campaign.user,
      creative: campaign.creative,
      publisher: property.user,
      property: property,
      ip_address: ip_address("US"),
      user_agent: Faker::Internet.user_agent,
      country_code: "US",
      province_code: "US-CA",
      postal_code: "94102",
      displayed_at: 1.day.ago,
      displayed_at_date: 1.day.ago.to_date
    }.merge(attributes))
  end
end
