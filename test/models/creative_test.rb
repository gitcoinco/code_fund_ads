# == Schema Information
#
# Table name: creatives
#
#  id              :bigint(8)        not null, primary key
#  user_id         :bigint(8)        not null
#  name            :string           not null
#  headline        :string           not null
#  body            :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  legacy_id       :uuid
#  organization_id :bigint(8)
#  cta             :string
#

require "test_helper"

class CreativeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
