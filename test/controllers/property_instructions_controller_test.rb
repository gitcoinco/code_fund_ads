require 'test_helper'

class PropertyInstructionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get property_instructions_show_url
    assert_response :success
  end

end
