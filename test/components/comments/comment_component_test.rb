require "test_helper"

class Comments::CommentComponentTest < ViewComponent::TestCase
  setup do
    @commentable = organizations(:default)
    @user = users(:administrator)
    @comment = create_comment(commentable: @commentable, user: @user)
    ApplicationComponent.any_instance.stubs(authorized_user: AuthorizedUser.new(@user))
  end

  test "basic comments form component" do
    render_inline(Comments::CommentComponent.new(comment: @comment))
    assert_selector(".conversation-inbound")
    assert_selector(".conversation-message")
    assert_selector(".dropdown")
    assert_text("Test comment.")
  end
end
