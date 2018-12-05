module Campaigns
  module Operable
    extend ActiveSupport::Concern

    def dates
      (start_date..end_date).to_a
    end

    def operative_dates
      return dates unless weekdays_only?
      dates.select { |date| !date.saturday? && !date.sunday? }
    end

    def total_operative_days
      operative_dates.size
    end

    def remaining_operative_dates
      today = Date.current
      operative_dates.select { |date| date >= today }
    end

    def remaining_operative_days
      remaining_operative_dates.size
    end

    def consumed_operative_days
      total_operative_days - remaining_operative_days
    end
  end
end
