module Campaigns
  module Presentable
    extend ActiveSupport::Concern
    include ActionView::Helpers::DateHelper
    include ActionView::Helpers::TextHelper

    def scoped_name(truncate: false)
      value = [organization&.name, user.name, name, creative&.name].compact.join "・"
      value = truncate(value, length: 60) if truncate
      value
    end

    def analytics_key
      [id, name].compact.join ": "
    end

    alias to_s analytics_key

    def duration
      return nil if total_operative_days.zero?
      distance_of_time_in_words(start_date.beginning_of_day, end_date.end_of_day, scope: "datetime.distance_in_words.short")
    end

    def percentage_complete_by_date
      return 0 if total_operative_days.zero?
      return 0 if start_date > Date.current
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

    # TODO: rename date_range to something more appropriate for ui only concerns like: date_range_string
    #       we should do this because `range` has programmatic meaning and this implementaiton is not it
    def date_range
      return nil unless start_date && end_date
      "#{start_date.to_s "mm/dd/yyyy"} - #{end_date.to_s "mm/dd/yyyy"}"
    end

    # TODO: rename date_range to something more appropriate for ui only concerns like: date_range_string
    #       we should do this because `range` has programmatic meaning and this implementaiton is not it
    def date_range=(value)
      dates = value.split(" - ")
      self.start_date = Date.strptime(dates[0], "%m/%d/%Y")
      self.end_date = Date.strptime(dates[1], "%m/%d/%Y")
    end
  end
end
