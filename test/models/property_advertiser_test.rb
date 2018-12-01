# == Schema Information
#
# Table name: property_advertisers
#
#  id            :bigint(8)        not null, primary key
#  property_id   :bigint(8)        not null
#  advertiser_id :bigint(8)        not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require "test_helper"

class PropertyAdvertiserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
