# == Schema Information
#
# Table name: property_advertisers
#
#  id                :bigint(8)        not null, primary key
#  property_id       :bigint(8)        not null
#  advertiser_id     :bigint(8)        not null
#  displayed_at_date :date             not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class PropertyAdvertiser < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :advertiser, class_name: "User", foreign_key: "advertiser_id"
  belongs_to :property

  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  scope :on, ->(date) { where displayed_at_date: date.to_date }
  scope :between, ->(start_date, end_date) { where displayed_at_date: start_date.to_date..end_date.to_date }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  # protected instance methods ................................................

  # private instance methods ..................................................
end
