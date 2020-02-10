module Campaigns
  module Operable
    extend ActiveSupport::Concern

    def total_operative_days
      operative_dates.size
    end

    def remaining_operative_days
      return Float::INFINITY if unending?
      remaining_operative_dates.size
    end

    def consumed_operative_days
      return total_operative_days if unending?
      total_operative_days - remaining_operative_days
    end

    def operable?
      remaining_operative_days > 0 && total_remaining_budget > 0
    end

    private

    def dates
      ed = unending? ? Date.current : end_date
      (start_date..ed).to_a
    rescue
      nil
    end

    # A campaign is unending if it does not have a set end date,
    # meaning it will continue running until manually stopped.
    def unending?
      end_date.nil?
    end

    def remaining_operative_dates
      today = Date.current
      operative_dates.select { |date| date >= today }
    end

    def operative_dates
      return dates unless weekdays_only?
      dates.select { |date| !date.saturday? && !date.sunday? }
    end
  end
end
