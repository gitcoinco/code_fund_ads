class CreateDailySummaryJob < ApplicationJob
  queue_as :daily_summary

  def perform(impressionable, date_string, scoped_by, scoped_by_type = nil)
    date = Date.coerce(date_string)
    return if date.today? || date.future?
    return if impressionable.daily_summaries.on(date).scoped_by(scoped_by, scoped_by_type).exists?
    return if impressionable.is_a?(Campaign) && !impressionable.available_on?(date)
    return unless impressionable.impressions.on(date).scoped_by(scoped_by, scoped_by_type).exists?

    rollup = Impression.connection.exec_query(
      impressionable.impressions.on(date).scoped_by(scoped_by, scoped_by_type)
      .select(Arel.star.count.as("impressions_count"))
      .select("count(*) FILTER (WHERE fallback_campaign = true) AS fallbacks_count")
      .select("count(*) FILTER (WHERE clicked_at_date IS NOT NULL) AS clicks_count")
      .select("count(DISTINCT ip_address) AS unique_ip_addresses_count")
      .select(Arel::Nodes::NamedFunction.new("ROUND", [Impression.arel_table[:estimated_gross_revenue_fractional_cents].sum]).as("gross_revenue"))
      .select(Arel::Nodes::NamedFunction.new("ROUND", [Impression.arel_table[:estimated_property_revenue_fractional_cents].sum]).as("property_revenue"))
      .select(Arel::Nodes::NamedFunction.new("ROUND", [Impression.arel_table[:estimated_house_revenue_fractional_cents].sum]).as("house_revenue"))
      .to_sql
    ).first
    impressionable.daily_summaries.on(date).scoped_by(scoped_by, scoped_by_type).first_or_create!(rollup)
  rescue ActiveRecord::RecordNotUnique => e
    logger.info "A race condition attempted to create the same DailySummary record more than once. #{e}"
  end
end
