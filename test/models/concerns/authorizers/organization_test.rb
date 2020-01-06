require "test_helper"

class Authorizers::OrganizationTest < ActiveSupport::TestCase
  setup do
    @organization = organizations(:default)
    @sys_admin = AuthorizedUser.new organization_users(:system_administrator).user
    @org_admin = AuthorizedUser.new organization_users(:administrator).user
    @member = AuthorizedUser.new organization_users(:member).user
    @other_org = copy organizations: :default,
                      name: "Other Org"
    other_user = copy users: :publisher,
                      first_name: "bob",
                      email: "burgers@test.com",
                      password: "password"

    OrganizationUser.new(user: other_user, organization: @other_org)
  end

  test "sys admins can edit their organization" do
    assert @sys_admin.can_edit_organization?(@organization)
  end

  test "org admins can edit their organization" do
    assert @org_admin.can_edit_organization?(@organization)
  end

  test "members can edit their organization" do
    assert @member.can_edit_organization?(@organization)
  end

  test "sys admins can edit organizations that they aren't in" do
    assert @sys_admin.can_edit_organization?(@other_org)
  end

  test "org admins and members cannot edit organizations that they aren't in" do
    assert_not @org_admin.can_edit_organization?(@other_org)
    assert_not @member.can_edit_organization?(@other_org)
  end

  test "sys admins can edit their organization users" do
    assert @sys_admin.can_edit_organization_users?(@organization)
  end

  test "org admins can edit their organization users" do
    assert @org_admin.can_edit_organization_users?(@organization)
  end

  test "members cannot edit their organization users" do
    assert_not @member.can_edit_organization_users?(@organization)
  end

  test "sys admins can edit organizations users that they aren't in" do
    assert @sys_admin.can_edit_organization_users?(@other_org)
  end

  test "org admins and members cannot edit organizations users that they aren't in" do
    assert_not @org_admin.can_edit_organization_users?(@other_org)
    assert_not @member.can_edit_organization_users?(@other_org)
  end
end
