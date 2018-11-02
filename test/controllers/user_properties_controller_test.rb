# frozen_string_literal: true

require "test_helper"

class UserPropertiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_properties_index_url
    assert_response :success
  end
end
