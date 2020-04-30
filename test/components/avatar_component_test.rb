require "test_helper"

class AvatarComponentTest < ViewComponent::TestCase
  setup do
    @user = users(:publisher)
  end

  test "basic avatar" do
    render_inline(AvatarComponent.new(user: @user))
    assert_selector(".user-avatar")
    assert_selector("[alt='#{@user.name} identicon']")
    assert_selector("[src='#{@user.gravatar_url("identicon")}']")
  end

  test "avatar with valid size" do
    render_inline(AvatarComponent.new(user: @user, size: "xl"))
    assert_selector(".user-avatar")
    assert_selector(".user-avatar-xl")
  end

  test "avatar with invalid size" do
    render_inline(AvatarComponent.new(user: @user, size: "foo"))
    assert_selector(".user-avatar")
    refute_selector(".user-avatar-foo")
  end
end
