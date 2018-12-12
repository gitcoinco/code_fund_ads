require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index" do
    get user_events_url(users(:advertiser))
    assert_response :success
  end
end
