require "test_helper"

class UserEmailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_emails_index_url
    assert_response :success
  end

  test "should get show" do
    get user_emails_show_url
    assert_response :success
  end
end
