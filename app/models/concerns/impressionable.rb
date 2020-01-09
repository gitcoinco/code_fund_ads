module Impressionable
  extend ActiveSupport::Concern

  included do
    has_many :impressions
    has_many :daily_summaries, as: :impressionable
    has_many :daily_summary_reports, as: :impressionable
  end

  def daily_impressions_counts(start_date = nil, end_date = nil, scoped_by: nil, fresh: false)
    start_date = constrained_date(start_date)
    end_date = constrained_date(end_date || start_date)
    key = "#{cache_key}/#{__method__}/#{start_date.iso8601}-#{end_date.iso8601}/#{scoped_by&.cache_key}"
    fetch_from_cache key, force: fresh do
      counts_by_date = daily_summaries.between(start_date, end_date).scoped_by(scoped_by)
        .pluck(:displayed_at_date, :impressions_count)
        .each_with_object({}) { |row, memo| memo[row[0]] = row[1] }
      dates = (start_date..end_date).to_a
      missing_dates = dates - counts_by_date.keys
      if missing_dates.present?
        impressions.on(*missing_dates).scoped_by(scoped_by).group(:displayed_at_date).count
          .each { |date, count| counts_by_date[date] ||= count }
      end
      dates.map { |date| counts_by_date[date] ||= 0 }
    end
  end

  def daily_clicks_counts(start_date = nil, end_date = nil, scoped_by: nil, fresh: false)
    start_date = constrained_date(start_date)
    end_date = constrained_date(end_date || start_date)
    key = "#{cache_key}/#{__method__}/#{start_date.iso8601}-#{end_date.iso8601}/#{scoped_by&.cache_key}"
    fetch_from_cache key, force: fresh do
      counts_by_date = daily_summaries.between(start_date, end_date).scoped_by(scoped_by)
        .pluck(:displayed_at_date, :clicks_count)
        .each_with_object({}) { |row, memo| memo[row[0]] = row[1] }
      dates = (start_date..end_date).to_a
      missing_dates = dates - counts_by_date.keys
      if missing_dates.present?
        impressions.clicked.on(*missing_dates).scoped_by(scoped_by).group(:displayed_at_date).count
          .each { |date, count| counts_by_date[date] ||= count }
      end
      dates.map { |date| counts_by_date[date] ||= 0 }
    end
  end

  def impressions_count(start_date = nil, end_date = nil, scoped_by: nil)
    daily_impressions_counts(start_date, end_date, scoped_by: scoped_by).sum
  end

  def clicks_count(start_date = nil, end_date = nil, scoped_by: nil)
    daily_clicks_counts(start_date, end_date, scoped_by: scoped_by).sum
  end

  def click_rate(start_date = nil, end_date = nil, scoped_by: nil)
    icount = impressions_count(start_date, end_date, scoped_by: scoped_by)
    ccount = clicks_count(start_date, end_date, scoped_by: scoped_by)
    icount.zero? ? 0 : (ccount / icount.to_f) * 100
  end

  def gross_revenue(start_date, end_date = nil, scoped_by: nil, fresh: false)
    start_date = constrained_date(start_date)
    end_date = constrained_date(end_date || start_date)
    key = "#{cache_key}/#{__method__}/#{start_date.iso8601}-#{end_date.iso8601}/#{scoped_by&.cache_key}"
    cents = fetch_from_cache(key, force: fresh) {
      cents_by_date = daily_summaries.between(start_date, end_date).scoped_by(scoped_by)
        .pluck(:displayed_at_date, :gross_revenue_cents)
        .each_with_object({}) { |row, memo| memo[row[0]] = row[1] }
      dates = (start_date..end_date).to_a
      missing_dates = dates - cents_by_date.keys
      if missing_dates.present?
        impressions.on(*missing_dates).scoped_by(scoped_by).group(:displayed_at_date).sum(:estimated_gross_revenue_fractional_cents)
          .each { |date, fractional_cents| cents_by_date[date] ||= fractional_cents.round }
      end
      cents_by_date.values.sum
    }.to_i
    Money.new cents, "USD"
  end

  def property_revenue(start_date, end_date = nil, scoped_by: nil, fresh: false)
    start_date = constrained_date(start_date)
    end_date = constrained_date(end_date || start_date)
    key = "#{cache_key}/#{__method__}/#{start_date.iso8601}-#{end_date.iso8601}/#{scoped_by&.cache_key}"
    cents = fetch_from_cache(key, force: fresh) {
      cents_by_date = daily_summaries.between(start_date, end_date).scoped_by(scoped_by)
        .pluck(:displayed_at_date, :property_revenue_cents)
        .each_with_object({}) { |row, memo| memo[row[0]] = row[1] }
      dates = (start_date..end_date).to_a
      missing_dates = dates - cents_by_date.keys
      if missing_dates.present?
        impressions.on(*missing_dates).scoped_by(scoped_by).group(:displayed_at_date).sum(:estimated_property_revenue_fractional_cents)
          .each { |date, fractional_cents| cents_by_date[date] ||= fractional_cents.round }
      end
      cents_by_date.values.sum
    }.to_i
    Money.new cents, "USD"
  end

  def house_revenue(start_date, end_date = nil, scoped_by: nil, fresh: false)
    start_date = constrained_date(start_date)
    end_date = constrained_date(end_date || start_date)
    key = "#{cache_key}/#{__method__}/#{start_date.iso8601}-#{end_date.iso8601}/#{scoped_by&.cache_key}"
    cents = fetch_from_cache(key, force: fresh) {
      cents_by_date = daily_summaries.between(start_date, end_date).scoped_by(scoped_by)
        .pluck(:displayed_at_date, :house_revenue_cents)
        .each_with_object({}) { |row, memo| memo[row[0]] = row[1] }
      dates = (start_date..end_date).to_a
      missing_dates = dates - cents_by_date.keys
      if missing_dates.present?
        impressions.on(*missing_dates).scoped_by(scoped_by).group(:displayed_at_date).sum(:estimated_house_revenue_fractional_cents)
          .each { |date, fractional_cents| cents_by_date[date] ||= fractional_cents.round }
      end
      cents_by_date.values.sum
    }.to_i
    Money.new cents, "USD"
  end

  def operational?
    daily_summaries.scoped_by(nil).sum(:impressions_count) > 100
  end

  private

  def constrained_date(value)
    return Date.coerce(value) unless is_a?(Campaign)
    Date.coerce value,
      min: start_date,
      max: (end_date.future? ? Date.current : end_date)
  end

  def fetch_from_cache(key, force: false, &block)
    fresh_key = "#{key}/fresh"
    value = Rails.cache.fetch(key, force: force, expires_in: 1.hour, race_condition_ttl: 5.minutes, &block)

    unless Rails.cache.exist? fresh_key
      # distributed lock that spans all dynos/processes to ensure only 1 process
      # in the distributed system updates the cache
      PgLock.new(name: key, attempts: 1).lock do
        value = block.call
        Rails.cache.write key, value, expires_in: 1.hour
        Rails.cache.write fresh_key, true, expires_in: 7.minutes
      end
    end

    value
  end
end
