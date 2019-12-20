require "test_helper"

class DemosControllerTest < ActionDispatch::IntegrationTest
  def setup
    @campaign = amend campaigns: :fallback, id: ENV["CAMPAIGN_DEMO_ID"]
  end

  test "should get show without signed in user" do
    get demo_path
    assert_response :success
  end

  test "should get show with signed in user" do
    sign_in_user(users(:publisher))
    get demo_path
    assert_response :success
  end

  test "should update demo" do
    patch demo_path params: {template: "centered", theme: "dark"}
    assert_redirected_to %r{.*(demo?template=centered&theme=dark)?}
  end
end
