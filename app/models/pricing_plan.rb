# == Schema Information
#
# Table name: pricing_plans
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_pricing_plans_on_name  (name) UNIQUE
#
class PricingPlan < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  has_many :campaign_bundles
  has_many :campaigns
  has_many :prices

  # validations ...............................................................
  validates :name, uniqueness: true

  # callbacks .................................................................
  # scopes ....................................................................
  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  # protected instance methods ................................................

  # private instance methods ..................................................
end
