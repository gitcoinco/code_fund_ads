require "test_helper"

class CampaignBudgetControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get campaign_budget_show_url
    assert_response :success
  end
end
