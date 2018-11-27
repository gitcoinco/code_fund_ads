require "test_helper"

class CampaignChangelogsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get campaign_changelogs_show_url
    assert_response :success
  end
end
