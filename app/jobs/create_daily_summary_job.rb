class CreateDailySummaryJob < ApplicationJob
  queue_as :low

  def perform(impressionable, date_string, scoped_by)
    date = Date.coerce(date_string)
    return if date.today? || date.future?
    return if impressionable.daily_summaries.on(date).scoped_by(scoped_by).exists?

    impressions = impressionable.impressions.on(date).scoped_by(scoped_by)

    impressionable.daily_summaries.create!(
      displayed_at_date: date,
      scoped_by_type: scoped_by&.class&.name,
      scoped_by_id: scoped_by&.id,
      impressions_count: impressions.count,
      clicks_count: impressions.clicked.count,
      estimated_gross_revenue: Money.new(impressions.sum(:estimated_gross_revenue_fractional_cents).round, "USD"),
      estimated_property_revenue: Money.new(impressions.sum(:estimated_property_revenue_fractional_cents).round, "USD"),
      estimated_house_revenue: Money.new(impressions.sum(:estimated_house_revenue_fractional_cents).round, "USD"),
    )
  end
end
