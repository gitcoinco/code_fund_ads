# == Schema Information
#
# Table name: impression_counters
#
#  id                :bigint(8)        not null, primary key
#  campaign_id       :bigint(8)        not null
#  property_id       :bigint(8)        not null
#  displayed_at_date :date             not null
#  count             :bigint(8)        default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require "test_helper"

class ImpressionCounterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
