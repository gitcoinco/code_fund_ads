require_relative "system_test_helper"

class AdsTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    start_date = Date.parse("2019-01-01")
    @premium_campaign = amend campaigns: :premium,
                              start_date: start_date,
                              end_date: start_date.advance(months: 3),
                              keywords: ENUMS::KEYWORDS.keys.sample(5)
    @premium_campaign.organization.update balance: Monetize.parse("$10,000 USD")
    @fallback_campaign = amend campaigns: :fallback,
                               start_date: @premium_campaign.start_date,
                               end_date: @premium_campaign.end_date
    @property = amend properties: :website, keywords: @premium_campaign.keywords.sample(3)
    travel_to start_date.to_time.advance(days: 15)
  end

  teardown do
    travel_back
  end

  test "premium ad sets correct urls" do
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_campaign_link @premium_campaign
    assert_impression_pixel @property
    assert_powered_by_link
  end

  test "fallback ad sets correct urls" do
    @premium_campaign.update keywords: []
    visit advertisement_tests_path(@property, test_country_code: "US")
    assert_campaign_link @fallback_campaign
    assert_impression_pixel @property
    assert_powered_by_link
  end
end
