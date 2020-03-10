module Sparklineable
  extend ActiveSupport::Concern

  def sparkline_impressions(start_date, end_date)
    dates = (start_date..end_date).to_a
    daily_impressions_counts(start_date, end_date).map.with_index do |count, index|
      {
        date: dates[index].to_s("%F"),
        value: count
      }
    end
  end

  def sparkline_clicks(start_date, end_date)
    dates = (start_date..end_date).to_a
    daily_clicks_counts(start_date, end_date).map.with_index do |count, index|
      {
        date: dates[index].to_s("%F"),
        value: count
      }
    end
  end
end
