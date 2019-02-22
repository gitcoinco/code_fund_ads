module Campaigns
  module Budgetable
    extend ActiveSupport::Concern
    # NOTE: Many of these formulae only work if the eCPM remains the same throughout the life of the campaign
    # TODO: Factor in changing eCPM over time

    # Returns a Money indicating how much budget has been spent
    def total_consumed_budget
      ecpm * total_impressions_per_mille
    end

    # Returns a Money indicating how much budget remains
    def total_remaining_budget
      total_budget - total_consumed_budget
    end

    # Returns a Money indicating how much budget will remain when the campaign ends
    def total_unusable_budget
      return Money.new(0, "USD") if ecpm.to_f.zero?
      total_remaining_budget - total_remaining_usable_budget
    end

    # Returns a boolean indicating if the campaign has available budget
    def budget_available?
      total_consumed_budget < total_budget
    end

    # Returns a boolean indicating if there will be a budget surplus when the campaign ends
    def budget_surplus?
      total_unusable_budget > Money.new(100, "USD")
    end

    # Returns a Money indicating how much usable budget remains (given the current daily budget)
    def total_remaining_usable_budget
      (estimated_max_remaining_impression_count / 1_000.to_f) * ecpm
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
      date = Date.coerce(date)
      cents = impressions.on(date).sum(:estimated_gross_revenue_fractional_cents).round
      Money.new(cents, "USD")
    end

    # Returns a boolean indicating if the campaign has available budget for the passed date (or today)
    def daily_budget_available?(date = nil)
      daily_consumed_budget(date) < daily_budget
    end
  end
end
