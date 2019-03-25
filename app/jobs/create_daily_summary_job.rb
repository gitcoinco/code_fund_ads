class CreateDailySummaryJob < ApplicationJob
  queue_as :low

  def perform(impressionable, date_string, scoped_by)
    date = Date.coerce(date_string)
    return if date.today? || date.future?
    return if impressionable.daily_summaries.on(date).scoped_by(scoped_by).exists?

    impressions = impressionable.impressions.on(date).scoped_by(scoped_by)

    DailySummary.transaction do
      impressionable.daily_summaries.on(date).scoped_by(scoped_by).first_or_create!(
        impressions_count: impressions.count,
        fallbacks_count: impressions.fallback.count,
        clicks_count: impressions.clicked.count,
        gross_revenue: Money.new(impressions.sum(:estimated_gross_revenue_fractional_cents).round, "USD"),
        property_revenue: Money.new(impressions.sum(:estimated_property_revenue_fractional_cents).round, "USD"),
        house_revenue: Money.new(impressions.sum(:estimated_house_revenue_fractional_cents).round, "USD"),
      )
    end
  rescue ActiveRecord::RecordNotUnique => e
    logger.info "A race condition attempted to create the same DailySummary record more than once. #{e}"
  end
end
