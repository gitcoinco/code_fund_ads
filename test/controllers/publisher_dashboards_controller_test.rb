require "test_helper"

class PublisherDashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get publisher_dashboards_show_url
    assert_response :success
  end
end
