module Sparklineable
  extend ActiveSupport::Concern

  def sparkline_impressions(start_date, end_date)
    date_range = (start_date..end_date).to_a
    daily_impressions_counts(start_date, end_date).map.with_index do |count, i|
      {
        name: "Impressions",
        date: date_range[i].to_s("%F"),
        value: count,
      }
    end
  end
end
