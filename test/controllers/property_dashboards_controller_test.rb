require "test_helper"

class PropertyDashboardsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get show" do
    get property_dashboards_url(properties(:website))
    assert_response :success
  end
end
