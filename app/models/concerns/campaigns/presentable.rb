module Campaigns
  module Presentable
    extend ActiveSupport::Concern
    include ActionView::Helpers::DateHelper

    def daily_spend_series(_days = 30)
      # Calculate spend for x days by day
      # TODO: Use roll-up data
      [[10, 8, 5, 7, 6, 6, 10, 10, 8, 5, 7, 6, 6, 10, 6, 6, 10, 10, 8, 5, 7, 6, 6, 10, 6, 6, 10, 10, 8]]
    end

    def duration
      return nil unless start_date && end_date
      distance_of_time_in_words(start_date, end_date, scope: "datetime.distance_in_words.short")
    end
  end
end
