# == Schema Information
#
# Table name: coupons
#
#  id               :bigint           not null, primary key
#  claimed          :integer          default(0), not null
#  code             :string           not null
#  coupon_type      :string           not null
#  description      :string
#  discount_percent :integer          default(0), not null
#  expires_at       :datetime         not null
#  quantity         :integer          default(99999), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_coupons_on_code  (code) UNIQUE
#

class Coupon < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  has_many :job_postings

  # validations ...............................................................
  validates :code, presence: true, uniqueness: true
  validates :coupon_type, presence: true, inclusion: {in: ENUMS::COUPON_TYPES.keys}
  validates :expires_at, null: false

  # callbacks .................................................................
  # scopes ....................................................................
  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def active?
    quantity > claimed && expires_at > Time.now
  end

  def percentage?
    coupon_type == ENUMS::COUPON_TYPES::PERCENTAGE
  end

  def apply_discount(amount)
    return amount unless active?

    case coupon_type
    when ENUMS::COUPON_TYPES::PERCENTAGE then amount * ((100 - discount_percent).to_f / 100.0)
    else amount
    end
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
end
