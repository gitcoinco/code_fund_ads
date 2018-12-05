module Campaigns
  module Recommendable
    extend ActiveSupport::Concern

    def recommended_daily_budget
      total_remaining_budget / remaining_operative_days
    end

    def recommended_end_date
      total_available_impression_count = ((total_remaining_budget.to_f / ecpm.to_f) * 1_000).ceil
      days = total_available_impression_count / estimated_max_daily_impression_count

      date = start_date
      date = Date.current if date.past?

      return date.advance(days: days) unless weekdays_only?

      count = 0
      while count < days
        count += 1 unless date.saturday? || date.sunday?
        date = date.advance(days: 1)
      end
      date
    end
  end
end
