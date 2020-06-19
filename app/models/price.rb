# == Schema Information
#
# Table name: prices
#
#  id              :bigint           not null, primary key
#  cpm_cents       :integer          default(0), not null
#  cpm_currency    :string           default("USD"), not null
#  rpm_cents       :integer          default(0), not null
#  rpm_currency    :string           default("USD"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  audience_id     :bigint           not null
#  pricing_plan_id :bigint           not null
#  region_id       :bigint           not null
#
# Indexes
#
#  index_prices_on_audience_id                                    (audience_id)
#  index_prices_on_pricing_plan_id_and_audience_id_and_region_id  (pricing_plan_id,audience_id,region_id) UNIQUE
#  index_prices_on_region_id                                      (region_id)
#
class Price < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :pricing_plan
  belongs_to :audience
  belongs_to :region
  has_many :campaign_bundles
  has_many :campaigns

  # validations ...............................................................
  validates :pricing_plan_id, uniqueness: {scope: [:audience_id, :region_id]}
  monetize :cpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :rpm_cents, numericality: {greater_than_or_equal_to: 0}

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
