# == Schema Information
#
# Table name: distributions
#
#  id          :uuid             not null, primary key
#  amount      :decimal(10, 2)   not null
#  currency    :string(255)      not null
#  range_start :datetime         not null
#  range_end   :datetime         not null
#  inserted_at :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class DistributionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
