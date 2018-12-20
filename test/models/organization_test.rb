# == Schema Information
#
# Table name: organizations
#
#  id               :bigint(8)        not null, primary key
#  name             :string           not null
#  balance_cents    :integer          default(0), not null
#  balance_currency :string           default("USD"), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require "test_helper"

class OrganizationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
