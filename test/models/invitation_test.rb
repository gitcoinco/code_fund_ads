# frozen_string_literal: true

# == Schema Information
#
# Table name: invitations
#
#  id          :uuid             not null, primary key
#  email       :string(255)
#  token       :string(255)
#  inserted_at :datetime         not null
#  updated_at  :datetime         not null
#  first_name  :string(255)
#  last_name   :string(255)
#

require "test_helper"

class InvitationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
