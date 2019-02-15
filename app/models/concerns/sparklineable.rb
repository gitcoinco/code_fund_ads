module Sparklineable
  extend ActiveSupport::Concern

  def sparkline_impressions(start_date, end_date)
    key = "#{cache_key}/#{__method__}/#{start_date&.cache_key}-#{end_date&.cache_key}"
    Rails.cache.fetch(key) {
      dates = (start_date..end_date).to_a
      daily_impressions_counts(start_date, end_date).map.with_index do |count, index|
        {
          name: "Impressions",
          date: dates[index].to_s("%F"),
          value: count,
        }
      end
    }
  end

  def sparkline_clicks(start_date, end_date)
    key = "#{cache_key}/#{__method__}/#{start_date&.cache_key}-#{end_date&.cache_key}"
    Rails.cache.fetch(key) {
      dates = (start_date..end_date).to_a
      daily_clicks_counts(start_date, end_date).map.with_index do |count, index|
        {
          name: "Clicks",
          date: dates[index].to_s("%F"),
          value: count,
        }
      end
    }
  end
end
