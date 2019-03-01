module Campaigns
  module Budgetable
    extend ActiveSupport::Concern
    # NOTE: Many of these formulae only work if the eCPM remains the same throughout the life of the campaign
    # TODO: Factor in changing eCPM over time

    # Returns a Money indicating how much budget has been spent
    def total_consumed_budget
      key = "#{cache_key}/total_consumed_budget/#{Date.current.cache_key(minutes_cached: 10)}"
      fractional_cents = Rails.cache.fetch(key) {
        impressions.sum(:estimated_gross_revenue_fractional_cents)
      }
      Money.new(fractional_cents.to_f.round, "USD")
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
    # Cached for 10 minutes if date is nil, yesterday, or today
    # Cached indefinitely if date is before yesterday
    def daily_consumed_budget(date = nil)
      date = Date.coerce(date)
      key = "#{cache_key}/daily_consumed_budget/#{date.cache_key(minutes_cached: 10)}"
      fractional_cents = Rails.cache.fetch(key) {
        impressions.on(date).sum(:estimated_gross_revenue_fractional_cents)
      }
      Money.new(fractional_cents.to_f.round, "USD")
    end

    # Returns a boolean indicating if the campaign has available budget for the passed date (or today)
    def daily_budget_available?(date = nil)
      daily_consumed_budget(date) < daily_budget
    end
  end
end
