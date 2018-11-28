# == Schema Information
#
# Table name: counters
#
#  id          :bigint(8)        not null, primary key
#  record_id   :bigint(8)        not null
#  record_type :string           not null
#  scope       :string           not null
#  segment     :string
#  count       :bigint(8)        default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require "test_helper"

class CounterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
