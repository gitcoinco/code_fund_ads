require "test_helper"

class CampaignNotesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get campaign_notes_show_url
    assert_response :success
  end
end
