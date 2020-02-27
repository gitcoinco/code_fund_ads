class CreateDailySummaryJob < ApplicationJob
  queue_as :daily_summary

  def perform(impressionable, date_string, scoped_by, scoped_by_type = nil)
    date = Date.coerce(date_string)
    return if date.today? || date.future?
    return if impressionable.daily_summaries.on(date).scoped_by(scoped_by, scoped_by_type).exists?
    return if impressionable.is_a?(Campaign) && !impressionable.available_on?(date)
    return unless impressionable.impressions.on(date).scoped_by(scoped_by, scoped_by_type).exists?

    impressions = impressionable.impressions.on(date).scoped_by(scoped_by, scoped_by_type)
      .select(
        :id,
        :fallback_campaign,
        :clicked_at,
        :ip_address,
        :estimated_gross_revenue_fractional_cents,
        :estimated_property_revenue_fractional_cents,
        :estimated_house_revenue_fractional_cents
      ).to_a

    DailySummary.transaction do
      impressionable.daily_summaries.on(date).scoped_by(scoped_by, scoped_by_type).first_or_create!(
        impressions_count: impressions.count,
        fallbacks_count: impressions.count(&:fallback?),
        clicks_count: impressions.count(&:clicked?),
        unique_ip_addresses_count: impressions.group_by(&:ip_address).count,
        gross_revenue: Money.new(impressions.sum(&:estimated_gross_revenue_fractional_cents).round, "USD"),
        property_revenue: Money.new(impressions.sum(&:estimated_property_revenue_fractional_cents).round, "USD"),
        house_revenue: Money.new(impressions.sum(&:estimated_house_revenue_fractional_cents).round, "USD"),
      )
    end
  rescue ActiveRecord::RecordNotUnique => e
    logger.info "A race condition attempted to create the same DailySummary record more than once. #{e}"
  end
end
