# == Schema Information
#
# Table name: coupons
#
#  id                   :bigint(8)        not null, primary key
#  code                 :string           not null
#  description          :string
#  coupon_type          :string           not null
#  discount_percent     :integer
#  fixed_price_cents    :integer          default(0), not null
#  fixed_price_currency :string           default("USD"), not null
#  expires_at           :datetime
#  available_count      :integer          default(99999)
#  claimed_count        :integer          default(0)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Coupon < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  # relationships .............................................................

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

  # protected instance methods ................................................

  # private instance methods ..................................................
end
