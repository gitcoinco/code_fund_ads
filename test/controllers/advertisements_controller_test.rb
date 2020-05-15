require "test_helper"

class AdvertisementsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "get advertisement blocked referer url" do
    AdvertisementsController.any_instance.stubs(ad_test?: false)
    Rails.env.stubs(production?: true)
    ActionDispatch::Request.any_instance.stubs(referer: "https://blockedurl.test/")
    campaign = active_campaign
    property = matched_property(campaign)
    get advertisements_url(property, format: :js)
    assert_response :forbidden
  end

  test "get advertisement with no referer url" do
    AdvertisementsController.any_instance.stubs(ad_test?: false, country_code: "US")
    Rails.env.stubs(production?: true)
    campaign = active_campaign
    Campaign.premium.where.not(id: campaign.id).delete_all
    property = matched_property(campaign)
    get advertisements_url(property, format: :js)
    assert_response :success
    assert response.body.include?("click?campaign_id=#{campaign.id}")
  end

  test "get advertisement with non-ascii url" do
    AdvertisementsController.any_instance.stubs(ad_test?: false, country_code: "US")
    Rails.env.stubs(production?: true)
    ActionDispatch::Request.any_instance.stubs(referer: "https://non-ascii.test/\xE4\xB8\x8B\xE8\xBD\xBD\xE5\x8A\xA9\xE6\x89\x8B")
    campaign = active_campaign
    property = matched_property(campaign)
    Campaign.where.not(id: campaign.id).delete_all
    get advertisements_url(property, format: :js)
    assert_response :success
    assert response.body.include?("click?campaign_id=#{campaign.id}")
  end

  test "get advertisement with active & matching campaign" do
    AdvertisementsController.any_instance.stubs(ad_test?: false, country_code: "US")
    Campaign.fallback.delete_all
    campaign = active_campaign
    property = matched_property(campaign)
    get advertisements_url(property, format: :js)
    assert_response :success
    assert response.body.include?("click?campaign_id=#{campaign.id}")
  end

  test "get advertisement with active & geo matching campaign" do
    campaign = active_campaign
    property = matched_property(campaign)
    self.remote_addr = ip_address("US")
    get advertisements_url(property, format: :js)
    assert_response :success
    assert response.body.include?("click?campaign_id=#{campaign.id}")
  end

  test "get advertisement with active & assigned_properties & geo not matching campaign" do
    campaign = active_campaign
    property = matched_property(campaign)
    campaign.update! country_codes: ["US"], assigned_property_ids: [property.id]
    self.remote_addr = ip_address("CN")
    get advertisements_url(property, format: :js)
    assert_response :success
    refute response.body.include?("click?campaign_id=#{campaign.id}")
  end

  test "get advertisement with active & assigned_properties & geo matching campaign" do
    campaign = active_campaign
    property = matched_property(campaign)
    campaign.update! country_codes: ["US"], assigned_property_ids: [property.id]
    self.remote_addr = ip_address("US")
    get advertisements_url(property, format: :js)
    assert_response :success
    assert response.body.include?("click?campaign_id=#{campaign.id}")
  end

  test "get advertisement with active but no geo matching campaigns" do
    AdvertisementsController.any_instance.stubs(ad_test?: false, country_code: "CN")
    campaign = active_campaign
    property = matched_property(campaign)
    self.remote_addr = ip_address("US")
    get advertisements_url(property, format: :js)
    assert_response :success
    assert response.body =~ /This is a fallback campaign/
  end

  test "get advertisement with no matching campaigns" do
    Campaign.fallback.delete_all
    campaign = inactive_campaign
    property = matched_property(campaign)
    get advertisements_url(property, format: :js)
    assert_response :success
    assert response.body =~ /"creative":{"name":null/
    assert response.body =~ /"urls":{"impression":"","campaign":""/
  end

  test "get advertisement with fallback campaign if request is local" do
    self.remote_addr = "127.0.0.1"
    campaign = fallback_campaign
    property = matched_property(campaign)
    get advertisements_url(property, format: :js)
    assert_response :success
    assert response.body.include?("click?campaign_id=#{campaign.id}")
  end

  test "get advertisement with active campaign if request is local" do
    self.remote_addr = "127.0.0.1"
    campaign = active_campaign
    property = matched_property(campaign)
    get advertisements_url(property, format: :js)
    assert_response :success
    assert response.body =~ /This is a fallback campaign/
  end

  test "get advertisement with fallback campaign" do
    campaign = fallback_campaign
    property = matched_property(campaign)
    get advertisements_url(property, format: :js)
    assert_response :success
    assert response.body.include?("click?campaign_id=#{campaign.id}")
  end

  test "get advertisement with paid fallback campaign" do
    campaign = fallback_campaign
    campaign.update fallback: false, paid_fallback: true
    property = properties(:website)
    get advertisements_url(property, format: :js)
    assert_response :success
    assert response.body.include?("click?campaign_id=#{campaign.id}")
  end

  test "get advertisement with fallback campaign when property doesn't allow fallbacks" do
    campaign = fallback_campaign
    property = matched_property(campaign)
    property.update! prohibit_fallback_campaigns: true
    get advertisements_url(property, format: :js)
    assert_response :success
    assert response.body =~ /"creative":{"name":null/
    assert response.body =~ /"urls":{"impression":"","campaign":""/
  end
end
