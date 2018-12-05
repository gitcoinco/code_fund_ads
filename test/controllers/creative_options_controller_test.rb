require "test_helper"

class CreativeOptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get campaign_creative_options_show_url
    assert_response :success
  end
end
