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

class ClickCounter < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :campaign
  belongs_to :property

  # validations ...............................................................
  validates :count, numericality: {greater_than_or_equal_to: 0}
  validates :clicked_at_date, presence: true

  # callbacks .................................................................

  # scopes ....................................................................
  scope :on, ->(date) { where clicked_at_date: date }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  # protected instance methods ................................................

  # private instance methods ..................................................
end
