require "test_helper"

class Api::GlobalStatsControllerTest < ActionDispatch::IntegrationTest
  test "should return success for all global stats" do
    get all_global_stats_path
    assert_response :success
  end

  test "should return success for impression total count" do
    get impressions_total_count_path
    assert_response :success
  end

  test "should return success impression click count" do
    get impressions_click_count_path
    assert_response :success
  end

  test "should return success for impression click rate" do
    get impressions_click_rate_path
    assert_response :success
  end
end
