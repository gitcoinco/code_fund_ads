# == Schema Information
#
# Table name: click_counters
#
#  id              :bigint(8)        not null, primary key
#  campaign_id     :bigint(8)        not null
#  property_id     :bigint(8)        not null
#  clicked_at_date :date             not null
#  count           :bigint(8)        default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require "test_helper"

class ClickCounterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
