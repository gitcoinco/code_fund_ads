# == Schema Information
#
# Table name: events
#
#  id             :bigint           not null, primary key
#  eventable_id   :bigint           not null
#  eventable_type :string           not null
#  tags           :string           default([]), is an Array
#  body           :text             not null
#  user_id        :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require "test_helper"

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
