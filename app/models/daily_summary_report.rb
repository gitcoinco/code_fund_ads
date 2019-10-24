# == Schema Information
#
# Table name: daily_summaries
#
#  id                        :bigint           not null, primary key
#  impressionable_type       :string           not null
#  impressionable_id         :bigint           not null
#  scoped_by_type            :string
#  scoped_by_id              :string
#  impressions_count         :integer          default(0), not null
#  fallbacks_count           :integer          default(0), not null
#  fallback_percentage       :decimal(, )      default(0.0), not null
#  clicks_count              :integer          default(0), not null
#  click_rate                :decimal(, )      default(0.0), not null
#  ecpm_cents                :integer          default(0), not null
#  ecpm_currency             :string           default("USD"), not null
#  cost_per_click_cents      :integer          default(0), not null
#  cost_per_click_currency   :string           default("USD"), not null
#  gross_revenue_cents       :integer          default(0), not null
#  gross_revenue_currency    :string           default("USD"), not null
#  property_revenue_cents    :integer          default(0), not null
#  property_revenue_currency :string           default("USD"), not null
#  house_revenue_cents       :integer          default(0), not null
#  house_revenue_currency    :string           default("USD"), not null
#  displayed_at_date         :date             not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  unique_ip_addresses_count :integer          default(0), not null
#

class DailySummaryReport < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :impressionable, polymorphic: true
  belongs_to :scoped_by, polymorphic: true, optional: true

  # validations ...............................................................
  # callbacks .................................................................

  # scopes ....................................................................

  default_scope -> {
    paid_impressions_count = Arel::Nodes::Subtraction.new(
      arel_table[:impressions_count].sum,
      arel_table[:fallbacks_count].sum
    )

    select(:impressionable_type, :impressionable_id, :scoped_by_type, :scoped_by_id)
      .select(arel_table[:unique_ip_addresses_count].sum.as("unique_ip_addresses_count"))
      .select(arel_table[:impressions_count].sum.as("impressions_count"))
      .select(arel_table[:fallbacks_count].sum.as("unpaid_impressions_count"))
      .select(paid_impressions_count.as("paid_impressions_count"))
      .select(arel_table[:clicks_count].sum.as("clicks_count"))
      .select(arel_table[:gross_revenue_cents].sum.as("gross_revenue_cents"))
      .select(arel_table[:property_revenue_cents].sum.as("property_revenue_cents"))
      .select(arel_table[:house_revenue_cents].sum.as("house_revenue_cents"))
      .select(arel_table[:click_rate].average.as("click_rate"))
      .group(:impressionable_type, :impressionable_id, :scoped_by_type, :scoped_by_id)
      .order("impressions_count desc")
  }

  scope :scoped_by_type, ->(type) {
    type.nil? ? where(scoped_by_type: nil, scoped_by_id: nil) : where(scoped_by_type: type)
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
  attribute :unpaid_impressions_count, :integer
  attribute :paid_impressions_count, :integer
  attribute :clicks_count, :integer
  attribute :gross_revenue_cents, :integer
  attribute :property_revenue_cents, :integer
  attribute :house_revenue_cents, :integer

  monetize :gross_revenue_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :property_revenue_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :house_revenue_cents, numericality: {greater_than_or_equal_to: 0}

  # class methods .............................................................

  # public instance methods ...................................................

  public

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

  # protected instance methods ................................................
  # private instance methods ..................................................
end
