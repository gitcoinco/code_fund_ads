module Impressionable
  extend ActiveSupport::Concern

  def daily_impressions_counts(start_date = nil, end_date = nil)
    start_date = Date.coerce(start_date)
    end_date = Date.coerce(end_date || start_date)
    key = "#{cache_key}/#{__method__}/#{start_date.cache_key}-#{end_date.cache_key}"
    Rails.cache.fetch key do
      counts_by_date = daily_summaries.between(start_date, end_date).each_with_object({}) { |daily_summary, memo|
        memo[daily_summary.displayed_at_date] = daily_summary.impressions_count
      }
      dates = (start_date..end_date).to_a
      missing_dates = dates - counts_by_date.keys
      if missing_dates.present?
        CreateDailySummariesJob.perform_later self, start_date.iso8601, end_date.iso8601
        impressions.on(*missing_dates).group(:displayed_at_date).count
          .each { |date, count| counts_by_date[date] ||= count }
      end
      dates.map { |date| counts_by_date[date] ||= 0 }
    end
  end

  def total_impressions_count(start_date = nil, end_date = nil)
    daily_impressions_counts(start_date, end_date).sum
  end

  def daily_clicks_counts(start_date = nil, end_date = nil)
    start_date = Date.coerce(start_date)
    end_date = Date.coerce(end_date || start_date)
    key = "#{cache_key}/#{__method__}/#{start_date.cache_key}-#{end_date.cache_key}"
    Rails.cache.fetch key do
      counts_by_date = daily_summaries.between(start_date, end_date).each_with_object({}) { |daily_summary, memo|
        memo[daily_summary.displayed_at_date] = daily_summary.clicks_count
      }
      dates = (start_date..end_date).to_a
      missing_dates = dates - counts_by_date.keys
      if missing_dates.present?
        CreateDailySummariesJob.perform_later self, start_date.iso8601, end_date.iso8601
        impressions.clicked.on(*missing_dates).group(:displayed_at_date).count
          .each { |date, count| counts_by_date[date] ||= count }
      end
      dates.map { |date| counts_by_date[date] ||= 0 }
    end
  end

  def total_clicks_count(start_date = nil, end_date = nil)
    daily_clicks_counts(start_date, end_date).sum
  end

  def total_click_rate(start_date = nil, end_date = nil)
    icount = total_impressions_count(start_date, end_date)
    ccount = total_clicks_count(start_date, end_date)
    icount.zero? ? 0 : (ccount / icount.to_f) * 100
  end

  def estimated_gross_revenue(start_date, end_date = nil)
    start_date = Date.coerce(start_date)
    end_date = Date.coerce(end_date || start_date)
    key = "#{cache_key}/#{__method__}/#{start_date.cache_key}-#{end_date.cache_key}"
    cents = Rails.cache.fetch(key) {
      cents_by_date = daily_summaries.between(start_date, end_date).each_with_object({}) { |daily_summary, memo|
        memo[daily_summary.displayed_at_date] = daily_summary.estimated_gross_revenue_cents
      }
      dates = (start_date..end_date).to_a
      missing_dates = dates - cents_by_date.keys
      if missing_dates.present?
        CreateDailySummariesJob.perform_later self, start_date.iso8601, end_date.iso8601
        impressions.on(*missing_dates).group(:displayed_at_date).sum(:estimated_gross_revenue_fractional_cents)
          .each { |date, fractional_cents| cents_by_date[date] ||= fractional_cents.round }
      end
      cents_by_date.values.sum
    }
    Money.new cents, "USD"
  end

  def estimated_property_revenue(start_date, end_date = nil)
    start_date = Date.coerce(start_date)
    end_date = Date.coerce(end_date || start_date)
    key = "#{cache_key}/#{__method__}/#{start_date.cache_key}-#{end_date.cache_key}"
    cents = Rails.cache.fetch(key) {
      cents_by_date = daily_summaries.between(start_date, end_date).each_with_object({}) { |daily_summary, memo|
        memo[daily_summary.displayed_at_date] = daily_summary.estimated_property_revenue_cents
      }
      dates = (start_date..end_date).to_a
      missing_dates = dates - cents_by_date.keys
      if missing_dates.present?
        CreateDailySummariesJob.perform_later self, start_date.iso8601, end_date.iso8601
        impressions.on(*missing_dates).group(:displayed_at_date).sum(:estimated_property_revenue_fractional_cents)
          .each { |date, fractional_cents| cents_by_date[date] ||= fractional_cents.round }
      end
      cents_by_date.values.sum
    }.to_i
    Money.new cents, "USD"
  end

  def estimated_house_revenue(start_date, end_date = nil)
    start_date = Date.coerce(start_date)
    end_date = Date.coerce(end_date || start_date)
    key = "#{cache_key}/#{__method__}/#{start_date.cache_key}-#{end_date.cache_key}"
    cents = Rails.cache.fetch(key) {
      cents_by_date = daily_summaries.between(start_date, end_date).each_with_object({}) { |daily_summary, memo|
        memo[daily_summary.displayed_at_date] = daily_summary.estimated_house_revenue_cents
      }
      dates = (start_date..end_date).to_a
      missing_dates = dates - cents_by_date.keys
      if missing_dates.present?
        CreateDailySummariesJob.perform_later self, start_date.iso8601, end_date.iso8601
        impressions.on(*missing_dates).group(:displayed_at_date).sum(:estimated_house_revenue_fractional_cents)
          .each { |date, fractional_cents| cents_by_date[date] ||= fractional_cents.round }
      end
      cents_by_date.values.sum
    }.to_i
    Money.new cents, "USD"
  end
end
