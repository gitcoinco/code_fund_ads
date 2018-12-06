# == Schema Information
#
# Table name: events
#
#  id             :bigint(8)        not null, primary key
#  eventable_id   :integer          not null
#  eventable_type :string           not null
#  tags           :string           default([]), is an Array
#  body           :text             not null
#  user_id        :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require "test_helper"

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
