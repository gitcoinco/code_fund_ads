module Impressionable
  extend ActiveSupport::Concern

  def total_impressions_count(start_date = nil, end_date = nil)
    return daily_impressions_counts(start_date, end_date).sum if start_date && end_date
    key = "#{cache_key}/#{__method__}/#{Date.current.cache_key minutes_cached: 15}"
    Rails.cache.fetch(key) { impressions.count }.to_i
  end

  def total_impressions_per_mille
    total_impressions_count.to_i / 1_000.to_f
  end

  def daily_impressions_count(date = nil)
    date = Date.coerce(date)
    key = "#{cache_key}/#{__method__}/#{date.cache_key minutes_cached: 15}"
    Rails.cache.fetch(key) {
      if date.past? && daily_summaries.on(date).exists?
        daily_summaries.on(date).limit(1).pluck(:impressions_count).first
      else
        CreateDailySummaryJob.perform_later self, date.iso8601 if date.past?
        impressions.on(date).count
      end
    }.to_i
  end

  def daily_impressions_counts(start_date = nil, end_date = nil)
    start_date = Date.coerce(start_date)
    end_date = Date.coerce(end_date)
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
      dates.each { |date| results[date] ||= 0 }
      results.sort.to_h
    end
  end

  def daily_impressions_per_mille(date = nil)
    daily_impressions_count(date).to_i / 1_000.to_f
  end

  def total_clicks_count(start_date = nil, end_date = nil)
    return daily_clicks_counts(start_date, end_date).sum if start_date && end_date
    key = "#{cache_key}/#{__method__}/#{Date.current.cache_key minutes_cached: 15}"
    Rails.cache.fetch(key) { impressions.clicked.count }
  end

  def daily_clicks_count(date = nil)
    date = Date.coerce(date)
    key = "#{cache_key}/#{__method__}/#{date.cache_key minutes_cached: 15}"
    Rails.cache.fetch(key) {
      if date.past? && daily_summaries.on(date).exists?
        daily_summaries.on(date).limit(1).pluck(:clicks_count).first
      else
        CreateDailySummaryJob.perform_later self, date.iso8601 if date.past?
        impressions.clicked.on(date).count
      end
    }.to_i
  end

  def daily_clicks_counts(start_date = nil, end_date = nil)
    key = "#{cache_key}/#{__method__}/#{Date.coerce(start_date).cache_key}-#{Date.coerce(end_date).cache_key}"
    Rails.cache.fetch(key) {
      results = impressions.clicked.between(start_date, end_date).group(:displayed_at_date).count
      (start_date..end_date).map { |date| results[date] || 0 }
    }
  end

  def total_click_rate(start_date = nil, end_date = nil)
    return 0 if total_impressions_count(start_date, end_date).zero?
    (total_clicks_count(start_date, end_date) / total_impressions_count(start_date, end_date).to_f) * 100
  end

  def daily_click_rate(date = nil)
    date = Date.coerce(date)
    if date.past? && daily_summaries.on(date).exists?
      return daily_summaries.on(date).limit(1).pluck(:click_rate).first
    end
    impressions_count = daily_impressions_count(date)
    clicks_count = daily_clicks_count(date)
    return 0 if impressions_count.zero?
    (clicks_count / impressions_count.to_f) * 100
  end

  def daily_click_rates(start_date = nil, end_date = nil)
    icounts = daily_impressions_counts(start_date, end_date)
    ccounts = daily_clicks_counts(start_date, end_date)
    icounts.map.with_index do |icount, i|
      icount > 0 ? (ccounts[i] / icount.to_f) * 100 : 0
    end
  end

  def click_rate(start_date = nil, end_date = nil)
    impressions = daily_impressions_counts(start_date, end_date).sum
    return 0 if impressions.zero?
    clicks = daily_clicks_counts(start_date, end_date).sum
    (clicks / impressions.to_f) * 100
  end

  def estimated_gross_revenue(start_date, end_date)
    key = "#{cache_key}/#{__method__}/#{Date.coerce(start_date).cache_key minutes_cached: 15}-#{Date.coerce(end_date).cache_key minutes_cached: 15}"
    cents = Rails.cache.fetch(key) {
      impressions.between(start_date, end_date).sum(:estimated_gross_revenue_fractional_cents).round
    }.to_i
    Money.new cents, "USD"
  end

  def estimated_property_revenue(start_date, end_date)
    key = "#{cache_key}/#{__method__}/#{Date.coerce(start_date).cache_key minutes_cached: 15}-#{Date.coerce(end_date).cache_key minutes_cached: 15}"
    cents = Rails.cache.fetch(key) {
      impressions.between(start_date, end_date).sum(:estimated_property_revenue_fractional_cents).round
    }.to_i
    Money.new cents, "USD"
  end

  def estimated_house_revenue(start_date, end_date)
    key = "#{cache_key}/#{__method__}/#{Date.coerce(start_date).cache_key minutes_cached: 15}-#{Date.coerce(end_date).cache_key minutes_cached: 15}"
    cents = Rails.cache.fetch(key) {
      impressions.between(start_date, end_date).sum(:estimated_house_revenue_fractional_cents).round
    }.to_i
    Money.new cents, "USD"
  end
end
