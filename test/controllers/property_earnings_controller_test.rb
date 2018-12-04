require "test_helper"

class PropertyEarningsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get property_earnings_show_url
    assert_response :success
  end
end
