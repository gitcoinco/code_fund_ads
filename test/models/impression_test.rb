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
#  province_code                               :string
#  uplift                                      :boolean          default(FALSE)
#

require "test_helper"

class ImpressionTest < ActiveSupport::TestCase
  setup do
    property = properties(:website)
    Current.organization = organizations(:default)
    campaign = amend(campaigns: :premium, start_date: 1.month.ago.to_date, end_date: 1.month.from_now.to_date)
    @impression = campaign.impressions.create!(
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
    )
  end

  test "calculated revenue with fixed ecpm campaign and unknown country" do
    @impression.update country_code: nil
    @impression.property.update revenue_percentage: 0.65
    @impression.campaign.update fixed_ecpm: true, ecpm: Monetize.parse("$3.00 USD")
    assert @impression.applicable_ecpm == Monetize.parse("$3.00 USD")
    assert @impression.calculate_estimated_gross_revenue_fractional_cents == 0.3
    assert @impression.calculate_estimated_property_revenue_fractional_cents == 0.195
    assert @impression.calculate_estimated_house_revenue_fractional_cents == 0.105
    assert @impression.calculate_estimated_property_revenue_fractional_cents + @impression.calculate_estimated_house_revenue_fractional_cents == @impression.calculate_estimated_gross_revenue_fractional_cents
  end

  test "calculated revenue with unknown country" do
    @impression.update country_code: nil, province_code: nil, postal_code: nil
    @impression.property.update revenue_percentage: 0.65
    @impression.campaign.update fixed_ecpm: false, ecpm: Monetize.parse("$3.00 USD")
    assert @impression.applicable_ecpm == Monetize.parse("$0.15 USD")
    assert @impression.calculate_estimated_gross_revenue_fractional_cents == 0.015
    assert @impression.calculate_estimated_property_revenue_fractional_cents == 0.00975
    assert @impression.calculate_estimated_house_revenue_fractional_cents == 0.00525
    assert @impression.calculate_estimated_property_revenue_fractional_cents + @impression.calculate_estimated_house_revenue_fractional_cents == @impression.calculate_estimated_gross_revenue_fractional_cents
  end

  test "calculated revenue with fixed ecpm campaign and known country" do
    @impression.update country_code: "RO"
    @impression.property.update revenue_percentage: 0.65
    @impression.campaign.update fixed_ecpm: true, ecpm: Monetize.parse("$3.00 USD")
    assert @impression.applicable_ecpm == Monetize.parse("$3.00 USD")
    assert @impression.calculate_estimated_gross_revenue_fractional_cents == 0.3
    assert @impression.calculate_estimated_property_revenue_fractional_cents == 0.195
    assert @impression.calculate_estimated_house_revenue_fractional_cents == 0.105
    assert @impression.calculate_estimated_property_revenue_fractional_cents + @impression.calculate_estimated_house_revenue_fractional_cents == @impression.calculate_estimated_gross_revenue_fractional_cents
  end

  test "calculated revenue with known country" do
    @impression.update country_code: "BB"
    @impression.property.update revenue_percentage: 0.7
    @impression.campaign.update fixed_ecpm: false, ecpm: Monetize.parse("$4.50 USD"), start_date: "2019-03-07", end_date: "2019-05-01"
    assert @impression.applicable_ecpm == Monetize.parse("$3.02 USD")
    assert @impression.calculate_estimated_gross_revenue_fractional_cents == 0.302
    assert @impression.calculate_estimated_property_revenue_fractional_cents == 0.2114
    assert @impression.calculate_estimated_house_revenue_fractional_cents == 0.0906
    assert @impression.calculate_estimated_property_revenue_fractional_cents + @impression.calculate_estimated_house_revenue_fractional_cents == @impression.calculate_estimated_gross_revenue_fractional_cents
  end

  test "calculated revenue with known country and old pricing based on campaign start date before 2019-03-07" do
    @impression.update country_code: "BB"
    @impression.property.update revenue_percentage: 0.7
    @impression.campaign.update fixed_ecpm: false, ecpm: Monetize.parse("$4.50 USD"), start_date: "2019-03-06", end_date: "2019-05-01"
    assert @impression.applicable_ecpm == Monetize.parse("$0.22 USD")
    assert @impression.calculate_estimated_gross_revenue_fractional_cents == 0.022
    assert @impression.calculate_estimated_property_revenue_fractional_cents == 0.0154
    assert @impression.calculate_estimated_house_revenue_fractional_cents == 0.0066
    assert @impression.calculate_estimated_property_revenue_fractional_cents + @impression.calculate_estimated_house_revenue_fractional_cents == @impression.calculate_estimated_gross_revenue_fractional_cents
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
end
