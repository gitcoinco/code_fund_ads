require "test_helper"

class PropertyKeywordsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get show" do
    get property_keywords_url(properties(:website))
    assert_response :success
  end
end
