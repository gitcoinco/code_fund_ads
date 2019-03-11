# == Schema Information
#
# Table name: daily_summaries
#
#  id                                  :bigint(8)        not null, primary key
#  impressionable_type                 :string           not null
#  impressionable_id                   :bigint(8)        not null
#  impressions_count                   :integer          default(0), not null
#  clicks_count                        :integer          default(0), not null
#  click_rate                          :decimal(, )      default(0.0), not null
#  ecpm_cents                          :integer          default(0), not null
#  ecpm_currency                       :string           default("USD"), not null
#  estimated_gross_revenue_cents       :integer          default(0), not null
#  estimated_gross_revenue_currency    :string           default("USD"), not null
#  estimated_property_revenue_cents    :integer          default(0), not null
#  estimated_property_revenue_currency :string           default("USD"), not null
#  estimated_house_revenue_cents       :integer          default(0), not null
#  estimated_house_revenue_currency    :string           default("USD"), not null
#  displayed_at_date                   :date             not null
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#

class DailySummary < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :record, polymorphic: true

  # validations ...............................................................
  validates :count, presence: true
  validates :displayed_at_date, presence: true

  # callbacks .................................................................
  before_save :set_click_rate
  before_save :set_ecpm

  # scopes ....................................................................
  scope :on, ->(date) { where displayed_at_date: Date.coerce(date) }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def impressions_per_mille
    impressions_count / 1000.to_f
  end

  # protected instance methods ................................................

  # private instance methods ..................................................

  private

  def set_click_rate
    self.click_rate = clicks_count / impressions_count.to_f if impressions_count > 0
  end

  def set_ecpm
    self.ecpm = estimated_gross_revenue / impressions_per_mille if impressions_count > 0
  end
end
