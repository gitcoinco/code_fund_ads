# == Schema Information
#
# Table name: coupons
#
#  id                   :bigint(8)        not null, primary key
#  code                 :string           not null
#  description          :string
#  coupon_type          :string           not null
#  discount_percent     :integer          default(0), not null
#  fixed_price_cents    :integer          default(0), not null
#  fixed_price_currency :string           default("USD"), not null
#  expires_at           :datetime         not null
#  quantity             :integer          default(99999), not null
#  claimed              :integer          default(0), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
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
  monetize :fixed_price_cents, numericality: {greater_than_or_equal_to: 0}

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def active?
    quantity > claimed && expires_at > Time.now
  end

  def apply_discount(amount)
    return amount unless active?

    case coupon_type
    when ENUMS::COUPON_TYPES::PERCENTAGE then amount * ((100 - discount_percent).to_f / 100.0)
    when ENUMS::COUPON_TYPES::FIXED_PRICE then fixed_price
    else amount
    end
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
end
