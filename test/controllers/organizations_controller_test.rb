require 'test_helper'

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get organizations_index_url
    assert_response :success
  end

  test "should get show" do
    get organizations_show_url
    assert_response :success
  end

  test "should get new" do
    get organizations_new_url
    assert_response :success
  end

  test "should get edit" do
    get organizations_edit_url
    assert_response :success
  end

end
