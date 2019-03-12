module Campaigns
  module Budgetable
    extend ActiveSupport::Concern
    # NOTE: Many of these formulae only work if the eCPM remains the same throughout the life of the campaign
    # TODO: Factor in changing eCPM over time

    # Returns a Money indicating how much budget has been spent
    def total_consumed_budget
      gross_revenue start_date, Date.current
    end

    # Returns a Money indicating how much budget remains
    def total_remaining_budget
      total_budget - total_consumed_budget
    end

    # Returns a Float indicating how much total budget percentage has been consumed
    def total_consumed_budget_percentage(date = nil)
      return 0.0 unless total_budget > 0
      (total_consumed_budget.cents / total_budget.cents.to_f) * 100
    end

    # Returns a Float indicating how much total budget percentage remains
    def total_remaining_budget_percentage(date = nil)
      return 0.0 unless total_budget > 0
      (total_remaining_budget.cents / total_budget.cents.to_f) * 100
    end

    # Returns a boolean indicating if the campaign has available budget
    def budget_available?
      total_consumed_budget < total_budget
    end

    # Returns a Money indicating how much budget remains for the passed date (or today)
    def daily_remaining_budget(date = nil)
      daily_budget - daily_consumed_budget(date)
    end

    # Returns a Float indicating how much budget percentage remains for the passed date (or today)
    def daily_remaining_budget_percentage(date = nil)
      return 0.0 unless daily_budget > 0
      (daily_remaining_budget(date).cents / daily_budget.cents.to_f) * 100
    end

    # Returns a Money indicating how much budget has been spent for the passed date (or today)
    def daily_consumed_budget(date = nil)
      gross_revenue date
    end

    # Returns a boolean indicating if the campaign has available budget for the passed date (or today)
    def daily_budget_available?(date = nil)
      daily_consumed_budget(date) < daily_budget
    end
  end
end
