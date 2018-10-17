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

class Distribution < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  # relationships .............................................................

  # validations ...............................................................
  validates :amount, numericality: { greater_than_or_equal_to: 0, allow_nil: false }
  validates :currency, length: { maximum: 255, allow_blank: false }
  validates :range_end, presence: true
  validates :range_start, presence: true

  # callbacks .................................................................
  # scopes ....................................................................
  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  # protected instance methods ................................................
  protected

  # private instance methods ..................................................
  private
end
