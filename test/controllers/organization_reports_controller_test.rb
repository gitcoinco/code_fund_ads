require 'test_helper'

class OrganizationReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get organization_reports_index_url
    assert_response :success
  end

  test "should get new" do
    get organization_reports_new_url
    assert_response :success
  end

  test "should get show" do
    get organization_reports_show_url
    assert_response :success
  end

end
