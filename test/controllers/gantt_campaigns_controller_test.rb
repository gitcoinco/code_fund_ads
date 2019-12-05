require 'test_helper'

class GanttCampaignsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get gantt_campaigns_show_url
    assert_response :success
  end

end
