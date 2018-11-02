# frozen_string_literal: true

require "test_helper"

class UserCampaignsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_campaigns_index_url
    assert_response :success
  end
end
