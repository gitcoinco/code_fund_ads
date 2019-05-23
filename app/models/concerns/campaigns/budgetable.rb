module Campaigns
  module Budgetable
    extend ActiveSupport::Concern
    # NOTE: Many of these formulae only work if the eCPM remains the same throughout the life of the campaign
    # TODO: Factor in changing eCPM over time

    included do
      before_save :init_hourly_budget
    end

    # Returns a Money indicating how much budget has been spent
    def total_consumed_budget
      gross_revenue start_date, Date.current
    end

    # Returns a Money indicating how much budget remains
    def total_remaining_budget
      value = total_budget - total_consumed_budget
      return organization.balance if organization.balance < value
      value
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

    # Returns a float indicating how much budget (fractional cents) has been spent for the current hour
    def hourly_consumed_budget_fractional_cents
      key = "#{cache_key}/hourly_consumed_budget_fractional_cents/#{Date.current.iso8601}/#{Time.current.hour}"
      Rails.cache.fetch(key, expires_in: 15.minutes) {
        impressions
          .on(Date.current)
          .time_between(Time.current.beginning_of_hour, Time.current.end_of_hour)
          .sum(:estimated_gross_revenue_fractional_cents)
      }.to_f
    end

    # Increments the cached value for hourly_consumed_budget_fractional_cents
    def increment_hourly_consumed_budget_fractional_cents(amount_fractional_cents)
      key = "#{cache_key}/hourly_consumed_budget_fractional_cents/#{Date.current.iso8601}/#{Time.current.hour}"
      Rails.cache.write key, hourly_consumed_budget_fractional_cents + amount_fractional_cents, expires_in: 1.hour
    end

    # Returns a Money indicating how much budget has been spent for the current hour
    def hourly_consumed_budget
      Money.new hourly_consumed_budget_fractional_cents.round, "USD"
    end

    # Budget availability helpers ............................................................................

    # Returns a boolean indicating if the campaign has available budget
    def budget_available?
      total_consumed_budget < total_budget
    end

    # Returns a boolean indicating if the campaign has available budget for the passed date (or today)
    def daily_budget_available?(date = nil)
      return false unless budget_available?
      daily_consumed_budget(date) < daily_budget
    end

    # Returns a boolean indicating if the campaign has available budget for the current hour
    def hourly_budget_available?
      return false unless daily_budget_available?
      hourly_consumed_budget < hourly_budget
    end

    private

    def init_hourly_budget
      return unless daily_budget > 0
      min = daily_budget / 12
      self.hourly_budget = min if hourly_budget < min
    end
  end
end
