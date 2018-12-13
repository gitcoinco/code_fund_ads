require "test_helper"

class CreativePreviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get creative_previews_show_url
    assert_response :success
  end
end
