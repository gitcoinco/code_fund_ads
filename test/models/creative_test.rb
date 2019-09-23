# == Schema Information
#
# Table name: creatives
#
#  id              :bigint           not null, primary key
#  user_id         :bigint           not null
#  name            :string           not null
#  headline        :string
#  body            :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  legacy_id       :uuid
#  organization_id :bigint
#  cta             :string
#  status          :string           default("pending")
#  creative_type   :string           default("standard"), not null
#

require "test_helper"

class CreativeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
