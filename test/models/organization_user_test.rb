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
  # test "the truth" do
  #   assert true
  # end
end
