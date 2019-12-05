module Audiences
  module Presentable
    extend ActiveSupport::Concern

    def dailies_stacked_bar_chart_series(start_date = nil, end_date = nil, region: nil)
      data = {
        labels: [],
        series: Array.new(2),
      }
      dailies(start_date, end_date, region: region).each_with_object(data) do |daily, memo|
        memo[:labels] << daily.displayed_at_date.to_s("mm/dd")
        memo[:series][0] ||= []
        memo[:series][0] << daily.impressions_count - daily.fallbacks_count
        memo[:series][1] ||= []
        memo[:series][1] << daily.fallbacks_count
      end
    end
  end
end
