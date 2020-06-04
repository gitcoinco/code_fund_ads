require "test_helper"

class AvatarComponentTest < ViewComponent::TestCase
  setup do
    @user = users(:publisher)
  end

  test "does not render without a user" do
    assert_equal("", render_inline(AvatarComponent.new).to_html.squish)
  end

  test "basic avatar component" do
    render_inline(AvatarComponent.new(user: @user))
    assert_selector(".user-avatar.user-avatar-md")
    assert_selector("[alt='#{@user.name} identicon']")
    assert_selector("[src='#{@user.gravatar_url("identicon")}']")
  end

  test "avatar with valid size component" do
    render_inline(AvatarComponent.new(user: @user, size: "xl"))
    assert_selector(".user-avatar")
    assert_selector(".user-avatar-xl")
  end

  test "avatar with invalid size component" do
    render_inline(AvatarComponent.new(user: @user, size: "foo"))
    assert_selector(".user-avatar.user-avatar-md")
    refute_selector(".user-avatar-foo")
  end
end
