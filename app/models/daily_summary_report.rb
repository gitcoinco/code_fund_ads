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
#  fallback_clicks_count     :bigint           default(0), not null
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

class DailySummaryReport < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  include DailySummaryReports::Presentable

  # relationships .............................................................

  belongs_to :impressionable, polymorphic: true
  belongs_to :scoped_by, polymorphic: true, optional: true

  # validations ...............................................................
  # callbacks .................................................................

  # scopes ....................................................................

  default_scope -> {
    select(:impressionable_type, :impressionable_id, :scoped_by_type, :scoped_by_id)
      .select(arel_table[:unique_ip_addresses_count].sum.as("unique_ip_addresses_count"))
      .select(arel_table[:impressions_count].sum.as("impressions_count"))
      .select(arel_table[:clicks_count].sum.as("clicks_count"))
      .select(arel_table[:gross_revenue_cents].sum.as("gross_revenue_cents"))
      .select(arel_table[:property_revenue_cents].sum.as("property_revenue_cents"))
      .select(arel_table[:house_revenue_cents].sum.as("house_revenue_cents"))
      .group(:impressionable_type, :impressionable_id, :scoped_by_type, :scoped_by_id)
      .order("impressions_count desc")
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

  scope :between, ->(start_date, end_date = nil) {
    start_date, end_date = range_boundary(start_date) if start_date.is_a?(Range)
    where displayed_at_date: Date.coerce(start_date)..Date.coerce(end_date)
  }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  self.table_name = "daily_summaries"

  attribute :impressionable_type, :string
  attribute :impressionable_id, :integer
  attribute :scoped_by_type, :string
  attribute :scoped_by_id, :string
  attribute :unique_ip_addresses_count, :integer
  attribute :impressions_count, :integer
  attribute :clicks_count, :integer
  attribute :gross_revenue_cents, :integer
  attribute :property_revenue_cents, :integer
  attribute :house_revenue_cents, :integer

  monetize :gross_revenue_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :property_revenue_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :house_revenue_cents, numericality: {greater_than_or_equal_to: 0}

  # class methods .............................................................

  # public instance methods ...................................................

  def readonly?
    true
  end

  def click_rate
    return 0.0 unless impressions_count > 0
    (clicks_count / impressions_count.to_f) * 100
  end

  def cpm
    return Money.new(0) unless impressions_count > 0
    gross_revenue / (impressions_count / 1000.to_f)
  end

  def cpc
    return Money.new(0) unless clicks_count > 0
    gross_revenue / clicks_count
  end

  def property_cpm
    return Money.new(0) unless impressions_count > 0
    property_revenue / (impressions_count / 1000.to_f)
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end
