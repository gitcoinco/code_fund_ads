require "test_helper"

class PropertyEarningsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @property = properties(:website)
  end

  test "should get show" do
    sign_in users(:administrator)
    get property_earnings_url(@property)
    assert_response :success
  end
end
