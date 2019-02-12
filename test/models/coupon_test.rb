# == Schema Information
#
# Table name: coupons
#
#  id               :bigint(8)        not null, primary key
#  code             :string           not null
#  description      :string
#  coupon_type      :string           not null
#  discount_percent :integer          default(0), not null
#  expires_at       :datetime         not null
#  quantity         :integer          default(99999), not null
#  claimed          :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require "test_helper"

class CouponTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
