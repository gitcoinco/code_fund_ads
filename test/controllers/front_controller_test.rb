require 'test_helper'

class FrontControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get front_show_url
    assert_response :success
  end

end
