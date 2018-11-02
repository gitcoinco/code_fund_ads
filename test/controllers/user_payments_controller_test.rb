# frozen_string_literal: true

require "test_helper"

class UserPaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_payments_index_url
    assert_response :success
  end
end
