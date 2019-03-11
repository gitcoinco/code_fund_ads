module Impressionable
  extend ActiveSupport::Concern

  def daily_impressions_counts(start_date = nil, end_date = nil)
    start_date = Date.coerce(start_date)
    end_date = Date.coerce(end_date || start_date)
    key = "#{cache_key}/#{__method__}/#{start_date.cache_key}-#{end_date.cache_key}"
    Rails.cache.fetch key do
      results = daily_summaries.between(start_date, end_date).each_with_object({}) { |daily_summary, memo|
        memo[daily_summary.displayed_at_date] = daily_summary.impressions_count
      }
      dates = (start_date..end_date).to_a
      impressions.on(*(dates - results.keys)).group(:displayed_at_date).count.each do |date, count|
        CreateDailySummaryJob.perform_later self, date.iso8601 if date.past?
        results[date] ||= count
      end
      dates.map { |date| results[date] ||= 0 }
    end
  end

  def daily_clicks_counts(start_date = nil, end_date = nil)
    start_date = Date.coerce(start_date)
    end_date = Date.coerce(end_date || start_date)
    key = "#{cache_key}/#{__method__}/#{start_date.cache_key}-#{end_date.cache_key}"
    Rails.cache.fetch key do
      results = daily_summaries.between(start_date, end_date).each_with_object({}) { |daily_summary, memo|
        memo[daily_summary.displayed_at_date] = daily_summary.clicks_count
      }
      dates = (start_date..end_date).to_a
      impressions.clicked.on(*(dates - results.keys)).group(:displayed_at_date).count.each do |date, count|
        CreateDailySummaryJob.perform_later self, date.iso8601 if date.past?
        results[date] ||= count
      end
      dates.map { |date| results[date] ||= 0 }
    end
  end

  def daily_click_rates(start_date = nil, end_date = nil)
    icounts = daily_impressions_counts(start_date, end_date)
    ccounts = daily_clicks_counts(start_date, end_date)
    icounts.map.with_index do |icount, i|
      icount.zero? ? 0 : (ccounts[i] / icount.to_f) * 100
    end
  end

  def estimated_gross_revenue(start_date, end_date = nil)
    start_date = Date.coerce(start_date)
    end_date = Date.coerce(end_date || start_date)
    key = "#{cache_key}/#{__method__}/#{start_date.cache_key}-#{end_date.cache_key}"
    cents = Rails.cache.fetch(key) {
      impressions.between(start_date, end_date).sum(:estimated_gross_revenue_fractional_cents).round
    }.to_i
    Money.new cents, "USD"
  end

  def estimated_property_revenue(start_date, end_date = nil)
    start_date = Date.coerce(start_date)
    end_date = Date.coerce(end_date || start_date)
    key = "#{cache_key}/#{__method__}/#{start_date.cache_key}-#{end_date.cache_key}"
    cents = Rails.cache.fetch(key) {
      impressions.between(start_date, end_date).sum(:estimated_property_revenue_fractional_cents).round
    }.to_i
    Money.new cents, "USD"
  end

  def estimated_house_revenue(start_date, end_date = nil)
    start_date = Date.coerce(start_date)
    end_date = Date.coerce(end_date || start_date)
    key = "#{cache_key}/#{__method__}/#{start_date.cache_key}-#{end_date.cache_key}"
    cents = Rails.cache.fetch(key) {
      impressions.between(start_date, end_date).sum(:estimated_house_revenue_fractional_cents).round
    }.to_i
    Money.new cents, "USD"
  end
end
