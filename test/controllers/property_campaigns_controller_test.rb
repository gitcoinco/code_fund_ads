require "test_helper"

class PropertyCampaignsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index" do
    get property_campaigns_url(properties(:website))
    assert_response :success
  end
end
