module Campaigns
  module Presentable
    extend ActiveSupport::Concern
    include ActionView::Helpers::DateHelper

    def scoped_name
      [user.scoped_name, name, creative&.name].compact.join "・"
    end

    def daily_spend_series(_days = 30)
      # Calculate spend for x days by day
      # TODO: Use roll-up data
      [[10, 8, 5, 7, 6, 6, 10, 10, 8, 5, 7, 6, 6, 10, 6, 6, 10, 10, 8, 5, 7, 6, 6, 10, 6, 6, 10, 10, 8]]
    end

    def duration
      return nil if total_operative_days.zero?
      distance_of_time_in_words(start_date, end_date, scope: "datetime.distance_in_words.short")
    end

    def percentage_complete_by_date
      return 0   if total_operative_days.zero?
      return 0   if start_date > Date.current
      return 100 if end_date < Date.current

      ((consumed_operative_days.to_f / total_operative_days.to_f) * 100).to_i
    end

    def percentage_complete_by_budget
      return 0 if total_budget.zero?
      ((total_consumed_budget.to_f / total_budget.to_f) * 100).to_i
    end
  end
end
