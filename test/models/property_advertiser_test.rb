# == Schema Information
#
# Table name: property_advertisers
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  advertiser_id :bigint           not null
#  property_id   :bigint           not null
#
# Indexes
#
#  index_property_advertisers_on_advertiser_id                  (advertiser_id)
#  index_property_advertisers_on_property_id                    (property_id)
#  index_property_advertisers_on_property_id_and_advertiser_id  (property_id,advertiser_id) UNIQUE
#

require "test_helper"

class PropertyAdvertiserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
