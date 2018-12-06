require "test_helper"

class PropertyKeywordsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get property_keywords_show_url
    assert_response :success
  end
end
