# == Schema Information
#
# Table name: organization_users
#
#  id              :bigint           not null, primary key
#  organization_id :bigint           not null
#  user_id         :bigint           not null
#  role            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require "test_helper"

class OrganizationUserTest < ActiveSupport::TestCase
  def setup
    @organization_user = organization_users(:member)
  end
  test "owners scope" do
    assert_equal [organization_users(:owner)], OrganizationUser.owners
  end

  test "administrators scope" do
    assert_equal [organization_users(:administrator)], OrganizationUser.administrators
  end

  test "members scope" do
    assert_equal [@organization_user], OrganizationUser.members
  end

  test "organization_id uniqueness validation" do
    ou = OrganizationUser.new(
      organization: @organization_user.organization,
      user: @organization_user.user,
      role: @organization_user.role,
    )
    assert_not ou.save
    assert_includes ou.errors.messages[:organization_id].to_s, "already been taken"
  end

  test "role inclusion validation" do
    ou = OrganizationUser.new(
      organization: @organization_user.organization,
      user: @organization_user.user,
      role: "foobar",
    )
    assert_not ou.save
    assert_includes ou.errors.messages[:role].to_s, "not included in the list"
  end
end
