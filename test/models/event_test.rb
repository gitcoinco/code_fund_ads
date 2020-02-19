# == Schema Information
#
# Table name: events
#
#  id             :bigint           not null, primary key
#  body           :text             not null
#  eventable_type :string           not null
#  tags           :string           default([]), is an Array
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  eventable_id   :bigint           not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_events_on_eventable_id_and_eventable_type  (eventable_id,eventable_type)
#  index_events_on_user_id                          (user_id)
#

require "test_helper"

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
