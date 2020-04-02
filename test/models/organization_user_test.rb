# == Schema Information
#
# Table name: organization_users
#
#  id              :bigint           not null, primary key
#  role            :string           default("member"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_organization_users_on_organization_id  (organization_id)
#  index_organization_users_on_uniqueness       (organization_id,user_id,role) UNIQUE
#  index_organization_users_on_user_id          (user_id)
#

require "test_helper"

class OrganizationUserTest < ActiveSupport::TestCase
  def setup
    @organization_user = organization_users(:member)
  end

  test "administrators scope" do
    assert_equal organization_users(:administrator).role, OrganizationUser.administrators.sample.role
  end

  test "members scope" do
    assert_equal @organization_user, OrganizationUser.members.sample
  end

  test "organization_id uniqueness validation" do
    ou = OrganizationUser.new(
      organization: @organization_user.organization,
      user: @organization_user.user,
      role: @organization_user.role
    )
    assert_not ou.save
    assert_includes ou.errors.messages[:organization_id].to_s, "already been taken"
  end

  test "role inclusion validation" do
    ou = OrganizationUser.new(
      organization: @organization_user.organization,
      user: @organization_user.user,
      role: "foobar"
    )
    assert_not ou.save
    assert_includes ou.errors.messages[:role].to_s, "not included in the list"
  end
end
