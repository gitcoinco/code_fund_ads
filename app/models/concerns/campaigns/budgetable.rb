module Campaigns
  module Budgetable
    extend ActiveSupport::Concern
    # NOTE: Many of these formulae only work if the eCPM remains the same throughout the life of the campaign
    # TODO: Factor in changing eCPM over time

    included do
      before_save :init_hourly_budget
      before_save :init_total_budget
    end

    def should_calculate_total_budget?
      if campaign_pricing_strategy?
        return false unless daily_budget > 0
        return false unless total_budget == 0
        return true
      end

      region_and_audience_pricing_strategy? && new_record?
    end

    def init_total_budget
      return unless should_calculate_total_budget?
      self.total_budget = total_operative_days * daily_budget
    end

    # Sponsor campaigns equate `total_budget` with `selling_price` because they are sold at a fixed price.
    #
    # Standard campaigns don't capture `selling_price` because the price is variable and because an
    # organization can add funds to their balance, then run N campaigns in parallel that all have their
    # `total_budget` set to the organization balance. In this scenario, the organization is looking to spend
    # all the funds they've added and don't have a preference regarding which campaigns actually spend the money.
    def selling_price
      return total_budget if sponsor?
      nil
    end

    # Returns a Money indicating how much budget has been spent
    def total_consumed_budget
      gross_revenue start_date, Date.current
    end

    # Returns a Money indicating how much budget remains
    def total_remaining_budget(include_org_balance: true)
      value = total_budget - total_consumed_budget
      return organization.balance if organization.balance < value && include_org_balance
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
      key = "#{cache_key}/hourly_consumed_budget_fractional_cents/#{Date.current.iso8601}"
      Rails.cache.fetch(key, expires_in: 10.minutes) {
        impressions
          .on(Date.current)
          .time_between(Time.current.beginning_of_hour, Time.current.end_of_hour)
          .sum(:estimated_gross_revenue_fractional_cents)
      }.to_f
    end

    # Increments the cached value for hourly_consumed_budget_fractional_cents
    def increment_hourly_consumed_budget_fractional_cents(amount_fractional_cents)
      key = "#{cache_key}/hourly_consumed_budget_fractional_cents/#{Date.current.iso8601}"
      Rails.cache.write key, hourly_consumed_budget_fractional_cents + amount_fractional_cents, expires_in: 10.minutes
    end

    # Returns a Money indicating how much budget has been spent for the current hour
    def hourly_consumed_budget
      Money.new hourly_consumed_budget_fractional_cents.round, "USD"
    end

    def average_daily_spend
      return Money.new(0) unless consumed_operative_days > 0
      return Money.new(0) unless summary
      overview = summary
      overview.gross_revenue / consumed_operative_days
    end

    def estimated_daily_spend
      return Money.new(0) unless remaining_operative_days > 0
      total_remaining_budget / remaining_operative_days
    end

    def estimated_days_until_budget_consumed
      return 0 unless average_daily_spend > 0
      (total_remaining_budget / average_daily_spend).ceil
    end

    def pacing_too_slow?
      estimated_daily_spend > average_daily_spend
    end

    def pacing_too_fast?
      return false unless remaining_operative_days - estimated_days_until_budget_consumed >= 7
      estimated_days_until_budget_consumed < remaining_operative_days
    end

    def should_increase_caps?
      estimated_daily_spend > daily_budget
    end

    def should_increase_inventory?
      return false if should_increase_caps?
      pacing_too_slow?
    end

    def gross_revenue_percentage
      (summary.gross_revenue / total_budget) * 100
    end

    def should_display_budget_warnings?
      return false if start_date.future? || start_date.today? || summary.nil?
      (percentage_complete_by_date - gross_revenue_percentage).abs >= 5
    end

    # Budget availability helpers ............................................................................

    # Returns a boolean indicating if the campaign has available budget
    def budget_available?
      return false unless organization.balance > 0
      return false unless total_remaining_budget > 0
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
      return unless hourly_budget == 0
      min = daily_budget / 18.to_f
      self.hourly_budget = daily_budget / 8.to_f
      self.hourly_budget = min if hourly_budget < min
    end
  end
end
