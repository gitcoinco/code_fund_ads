require "test_helper"

class CommentsComponentTest < ViewComponent::TestCase
  setup do
    @commentable = organizations(:default)
  end

  test "comments component without comments" do
    render_inline(CommentsComponent.new(commentable: @commentable, comments: []))
    assert_selector(".conversations")
    assert_selector(".conversation-list")
    assert_text("There are currently no comments for this resource.")
  end

  test "comments component with comments" do
    user = users(:administrator)
    ApplicationComponent.any_instance.stubs(authorized_user: AuthorizedUser.new(user))
    render_inline(CommentsComponent.new(commentable: @commentable, comments: [
      create_comment(commentable: @commentable, user: user)
    ]))
    assert_selector(".conversations")
    assert_selector(".conversation-list")
    assert_no_text("There are currently no comments for this resource.")
  end
end
