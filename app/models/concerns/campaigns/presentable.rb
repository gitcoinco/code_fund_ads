module Campaigns
  module Presentable
    extend ActiveSupport::Concern
    include ActionView::Helpers::DateHelper
    include ActionView::Helpers::TextHelper

    def scoped_name(truncate: false)
      value = [user.scoped_name, name, creative&.name].compact.join "・"
      value = truncate(value, length: 60) if truncate
      value
    end

    def analytics_key
      [id, name].compact.join ": "
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

    def percentage_complete_by_daily_budget
      return 0 if total_budget.zero?
      return 0 if daily_budget.zero?
      return 0 if daily_remaining_budget.zero?
      consumed_budget_for_today = (daily_budget - daily_remaining_budget)
      ((consumed_budget_for_today.to_f / daily_budget.to_f) * 100).to_i
    end
  end
end
