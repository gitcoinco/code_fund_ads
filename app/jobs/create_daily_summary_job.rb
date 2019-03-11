class CreateDailySummaryJob < ApplicationJob
  queue_as :low

  def perform(impressionable, date_string)
    date = Date.coerce(date_string)
    return if date.today? || date.future?
    return if impressionable.daily_summaries.on(date).exists?

    impressions = impressionable.impressions.on(date)

    impressionable.daily_summaries.create!(
      displayed_at_date: date,
      impressions_count: impressions.count,
      clicks_count: impressions.clicked.count,
      estimated_gross_revenue: Money.new(impressions.sum(:estimated_gross_revenue_fractional_cents).round, "USD"),
      estimated_property_revenue: Money.new(impressions.sum(:estimated_property_revenue_fractional_cents).round, "USD"),
      estimated_house_revenue: Money.new(impressions.sum(:estimated_house_revenue_fractional_cents).round),
    )
  end
end
