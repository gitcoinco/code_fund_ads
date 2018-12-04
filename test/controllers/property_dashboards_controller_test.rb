require "test_helper"

class PropertyDashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get property_dashboards_show_url
    assert_response :success
  end
end
