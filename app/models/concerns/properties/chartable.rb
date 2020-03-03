module Properties
  module Chartable
    def chart_payload(start_date, end_date)
      dailies = daily_summaries_by_day(start_date, end_date)
      labels = dailies.map { |d| d.displayed_at_date.strftime("%m/%-d") }
      series = []
      series << dailies.map { |daily| daily.impressions_count }
      # series << dailies.map { |daily| daily.clicks_count } if values.include?(:clicks)
      # series << dailies.map { |daily| daily.property_revenue_cents.to_f / 100 } if values.include?(:revenue)
      {
        labels: labels,
        series: series
      }
    end
  end
end
