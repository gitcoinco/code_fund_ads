module Audiences
  module Presentable
    extend ActiveSupport::Concern

    def stacked_bar_chart_series(start_date, end_date, region:, total_budget:)
      dates = (Date.coerce(start_date)..Date.coerce(end_date)).to_a
      daily_impressions = average_daily_impressions(region: region)
      daily_impressions_reserved = (purchasable_impressions(start_date, end_date, region: region, total_budget: total_budget) / dates.size.to_f).round

      dates.each_with_object(labels: [], series: []) do |date, memo|
        memo[:labels] << date.to_s("mm/dd")

        reserved = daily_impressions_reserved
        reserved = daily_impressions[date.day] if reserved > daily_impressions[date.day]

        # total inventory
        memo[:series][0] ||= []
        memo[:series][0] << daily_impressions[date.day] - reserved

        # purchashed inventory
        memo[:series][1] ||= []
        memo[:series][1] << reserved
      end
    end
  end
end
