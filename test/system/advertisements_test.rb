require "application_system_test_case"

class AdvertisementsTest < ApplicationSystemTestCase
  setup do
    start_date = Date.parse("2019-01-01")
    @premium_campaign = amend campaigns: :premium,
                              start_date: start_date,
                              end_date: start_date.advance(months: 3),
                              keywords: ENUMS::KEYWORDS.keys.sample(5)
    @fallback_campaign = amend campaigns: :fallback,
                               start_date: @premium_campaign.start_date,
                               end_date: @premium_campaign.end_date
    @property = amend properties: :website, keywords: @premium_campaign.keywords.sample(3)
    travel_to start_date.to_time.advance(days: 15)
  end

  teardown do
    travel_back
  end

  test "js: premium ad sets correct urls" do
    visit advertisement_tests_path(@property, format: :js, test_country_code: "US")
    assert_css "a[data-href='campaign_url'][href*='click?campaign_id=#{@premium_campaign.id}']"
    assert_css "img[data-src='impression_url'][src*='gif?template=#{@property.ad_template}']"
  end

  test "js: fallback ad sets correct urls" do
    @premium_campaign.update keywords: []
    visit advertisement_tests_path(@property, format: :js)
    assert_css "a[data-href='campaign_url'][href*='click?campaign_id=#{@fallback_campaign.id}']"
    assert_css "img[data-src='impression_url'][src*='template=#{@property.ad_template}']"
  end
end
