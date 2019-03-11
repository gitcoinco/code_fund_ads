class CreateDailySummaryJob < ApplicationJob
  queue_as :low

  def perform(impressionable, date_string)
    date = Date.coerce(date_string)
    return if date.today? || date.future?
    return if impressionable.daily_summaries.on(date).exists?

    DailySummary.create!(
      impressions_count: impressionable.impressions.on(date).count,
      clicks_count: impressionable.impressions.clicked.on(date).count,
      click_rate: 0.0, # TODO
      estimated_gross_revenue: Money.new(impressionable.impressions.on(date).sum(:estimated_gross_revenue_fractional_cents).round, "USD"),
      estimated_property_revenue: Money.new(impressionable.impressions.on(date).sum(:estimated_property_revenue_fractional_cents).round, "USD"),
      estimated_house_revenue: Money.new(impressionable.impressions.on(date).sum(:estimated_house_revenue_fractional_cents).round),
    )
  end
end
