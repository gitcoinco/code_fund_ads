require 'test_helper'

class EmailTemplatesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get email_templates_index_url
    assert_response :success
  end

  test "should get show" do
    get email_templates_show_url
    assert_response :success
  end

  test "should get new" do
    get email_templates_new_url
    assert_response :success
  end

  test "should get edit" do
    get email_templates_edit_url
    assert_response :success
  end

end
