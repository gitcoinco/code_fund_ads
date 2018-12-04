require "test_helper"

class PropertyCampaignsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get property_campaigns_index_url
    assert_response :success
  end
end
