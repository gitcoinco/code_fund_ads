module Sparklineable
  extend ActiveSupport::Concern

  def sparkline_impressions(start_date, end_date)
    key = "#{cache_key}/#{__method__}/#{Date.cache_key(start_date, coerce: false)}-#{Date.cache_key(end_date, coerce: false)}"
    Rails.cache.fetch(key) {
      date_range = (start_date..end_date).to_a
      date_range.map do |date|
        count = daily_impressions_count date
        {
          name: "Impressions",
          date: date.to_s("%F"),
          value: count,
        }
      end
    }
  end

  def sparkline_clicks(start_date, end_date)
    key = "#{cache_key}/#{__method__}/#{Date.cache_key(start_date, coerce: false)}-#{Date.cache_key(end_date, coerce: false)}"
    Rails.cache.fetch(key) {
      date_range = (start_date..end_date).to_a
      date_range.map do |date|
        count = daily_clicks_count date
        {
          name: "Clicks",
          date: date.to_s("%F"),
          value: count,
        }
      end
    }
  end
end
