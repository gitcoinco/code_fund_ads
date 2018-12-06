module Campaigns
  module Budgetable
    extend ActiveSupport::Concern
    # NOTE: Many of these formulae only work if the eCPM remains the same throughout the life of the campaign
    # TODO: Factor in changing eCPM over time

    def total_consumed_budget
      ecpm * total_impressions_per_mille
    end

    def total_remaining_budget
      total_budget - total_consumed_budget
    end

    def total_unusable_budget
      return Money.new(0, "USD") if ecpm.to_f.zero?
      total_remaining_budget - total_remaining_usable_budget
    end

    def budget_surplus?
      total_unusable_budget > Money.new(100, "USD")
    end

    def total_remaining_usable_budget
      (estimated_max_remaining_impression_count / 1_000.to_f) * ecpm
    end

    def daily_remaining_budget
      daily_budget - daily_consumed_budget
    end

    def daily_consumed_budget
      ecpm * daily_impressions_per_mille
    end
  end
end
