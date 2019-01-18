require "test_helper"

class AdvertisementsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "get advertisement with active & matching campaign" do
    campaign = active_campaign
    property = matched_property(campaign)
    get advertisements_url(property, format: :js)
    assert_response :success
    assert response.body.include?("targetElement.innerHTML = '<div id=\"cf\"")
  end

  test "get advertisement with active & geo matching campaign" do
    self.remote_addr = "192.168.0.100"
    campaign = active_campaign(country_codes: ["US"])
    property = matched_property(campaign)
    get advertisements_url(property, format: :js)
    assert_response :success
    assert response.body.include?("targetElement.innerHTML = '<div id=\"cf\"")
  end

  test "get advertisement with active but no geo matching campaigns" do
    self.remote_addr = "192.168.0.100"
    campaign = active_campaign(country_codes: ["CA"])
    property = matched_property(campaign)
    get advertisements_url(property, format: :js)
    assert_response :success
    assert response.body.include?("CodeFund does not have a advertiser for you at this time.")
  end

  test "get advertisement with no matching campaigns" do
    campaign = inactive_campaign
    property = matched_property(campaign)
    get advertisements_url(property, format: :js)
    assert_response :success
    assert response.body.include?("CodeFund does not have a advertiser for you at this time.")
  end

  test "get advertisement with fallback campaign" do
    campaign = fallback_campaign
    property = matched_property(campaign)
    get advertisements_url(property, format: :js)
    assert_response :success
    assert response.body.include?("targetElement.innerHTML = '<div id=\"cf\"")
  end

  test "get advertisement with fallback campaign when property doesn't allow fallbacks" do
    campaign = fallback_campaign
    property = matched_property(campaign)
    property.update! prohibit_fallback_campaigns: true
    get advertisements_url(property, format: :js)
    assert_response :success
    assert response.body.include?("CodeFund does not have a advertiser for you at this time.")
  end

  private

  def active_campaign(country_codes: [])
    campaign = campaigns(:exclusive)
    campaign.update!(
      status: ENUMS::CAMPAIGN_STATUSES::ACTIVE,
      start_date: 1.month.ago,
      end_date: 1.month.from_now,
      country_codes: country_codes,
      keywords: ENUMS::KEYWORDS.keys.sample(10)
    )
    campaign.creative.add_image! attach_large_image!(campaign.user)
    campaign
  end

  def inactive_campaign
    campaign = campaigns(:exclusive)
    campaign.update!(
      status: ENUMS::CAMPAIGN_STATUSES::ARCHIVED,
      start_date: 6.months.ago,
      end_date: 4.months.ago,
      keywords: ENUMS::KEYWORDS.keys.sample(10)
    )
    campaign
  end

  def fallback_campaign
    campaign = campaigns(:exclusive)
    campaign.update!(
      status: ENUMS::CAMPAIGN_STATUSES::ACTIVE,
      start_date: 1.month.ago,
      end_date: 1.month.from_now,
      keywords: [],
      fallback: true
    )
    campaign.creative.add_image! attach_large_image!(campaign.user)
    campaign
  end

  def matched_property(campaign, fixture: :website)
    property = properties(fixture)
    property.update! keywords: campaign.keywords.sample(5)
    property
  end
end
