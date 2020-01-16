# == Schema Information
#
# Table name: daily_summaries
#
#  id                        :bigint           not null, primary key
#  click_rate                :decimal(, )      default(0.0), not null
#  clicks_count              :integer          default(0), not null
#  cost_per_click_cents      :integer          default(0), not null
#  cost_per_click_currency   :string           default("USD"), not null
#  displayed_at_date         :date             not null
#  ecpm_cents                :integer          default(0), not null
#  ecpm_currency             :string           default("USD"), not null
#  fallback_percentage       :decimal(, )      default(0.0), not null
#  fallbacks_count           :integer          default(0), not null
#  gross_revenue_cents       :integer          default(0), not null
#  gross_revenue_currency    :string           default("USD"), not null
#  house_revenue_cents       :integer          default(0), not null
#  house_revenue_currency    :string           default("USD"), not null
#  impressionable_type       :string           not null
#  impressions_count         :integer          default(0), not null
#  property_revenue_cents    :integer          default(0), not null
#  property_revenue_currency :string           default("USD"), not null
#  scoped_by_type            :string
#  unique_ip_addresses_count :integer          default(0), not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  impressionable_id         :bigint           not null
#  scoped_by_id              :string
#
# Indexes
#
#  index_daily_summaries_on_displayed_at_date       (displayed_at_date)
#  index_daily_summaries_on_impressionable_columns  (impressionable_type,impressionable_id)
#  index_daily_summaries_on_scoped_by_columns       (scoped_by_type,scoped_by_id)
#  index_daily_summaries_uniqueness                 (impressionable_type,impressionable_id,scoped_by_type,scoped_by_id,displayed_at_date) UNIQUE
#  index_daily_summaries_unscoped_uniqueness        (impressionable_type,impressionable_id,displayed_at_date) UNIQUE WHERE ((scoped_by_type IS NULL) AND (scoped_by_id IS NULL))
#

class DailySummary < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :impressionable, polymorphic: true
  belongs_to :scoped_by, polymorphic: true, optional: true

  # validations ...............................................................
  validates :impressions_count, numericality: {greater_than_or_equal_to: 0}
  validates :clicks_count, numericality: {greater_than_or_equal_to: 0}
  validates :click_rate, numericality: {greater_than_or_equal_to: 0}
  validates :displayed_at_date, presence: true

  # callbacks .................................................................
  before_save :set_fallback_percentage
  before_save :set_click_rate
  before_save :set_cost_per_click
  before_save :set_ecpm

  # scopes ....................................................................
  scope :displayed, -> { where arel_table[:impressions_count].gt(0) }
  scope :clicked, -> { where arel_table[:clicks_count].gt(0) }
  scope :on, ->(*dates) { where displayed_at_date: dates.map { |date| Date.coerce(date) } }
  scope :between, ->(start_date, end_date = nil) {
    start_date, end_date = range_boundary(start_date) if start_date.is_a?(Range)
    where displayed_at_date: Date.coerce(start_date)..Date.coerce(end_date)
  }
  scope :scoped_by_type, ->(type) {
    type.nil? ? where(scoped_by_type: nil, scoped_by_id: nil) : where(scoped_by_type: type)
  }
  scope :scoped_by, ->(value, type = nil) {
    case value
    when Campaign, Property, Creative then where(scoped_by_type: value.class.name, scoped_by_id: value.id)
    else where scoped_by_type: type, scoped_by_id: value
    end
  }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  monetize :cost_per_click_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :gross_revenue_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :property_revenue_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :house_revenue_cents, numericality: {greater_than_or_equal_to: 0}
  alias cpm ecpm
  alias cpc cost_per_click

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  # protected instance methods ................................................

  # private instance methods ..................................................

  private

  def set_fallback_percentage
    self.fallback_percentage = (fallbacks_count / impressions_count.to_f) * 100 if impressions_count > 0
  end

  def set_click_rate
    self.click_rate = (clicks_count / impressions_count.to_f) * 100 if impressions_count > 0
  end

  def set_cost_per_click
    self.cost_per_click = gross_revenue / clicks_count.to_f if clicks_count > 0
  end

  def set_ecpm
    impressions_per_mille = impressions_count / 1000.to_f
    self.ecpm = gross_revenue / impressions_per_mille if impressions_per_mille > 0
  end
end
