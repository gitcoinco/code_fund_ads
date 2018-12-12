require "test_helper"

class AdvertiserDashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get advertiser_dashboards_show_url
    assert_response :success
  end
end
