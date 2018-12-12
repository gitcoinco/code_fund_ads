require "test_helper"

class AdministratorDashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get administrator_dashboards_show_url
    assert_response :success
  end
end
