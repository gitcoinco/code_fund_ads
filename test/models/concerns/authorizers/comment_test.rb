require "test_helper"

class Authorizers::CommentTest < ActiveSupport::TestCase
  setup do
    @organization = organizations(:default)
    @sys_admin = AuthorizedUser.new organization_users(:system_administrator).user
    @org_admin = AuthorizedUser.new organization_users(:administrator).user
  end

  test "sys admins can create comments" do
    assert @sys_admin.can_create_comment?
  end

  test "non sys admins cannot create comments" do
    assert_not @org_admin.can_create_comment?
  end

  test "sys admins can destroy comments" do
    assert @sys_admin.can_destroy_comment?
  end

  test "non sys admins cannot destroy comments" do
    assert_not @org_admin.can_destroy_comment?
  end

  test "sys admins can view comments" do
    assert @sys_admin.can_view_comments?
  end

  test "non sys admins cannot view comments" do
    assert_not @org_admin.can_view_comments?
  end
end
