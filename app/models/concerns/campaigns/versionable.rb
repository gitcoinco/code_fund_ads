module Campaigns
  module Versionable
    extend ActiveSupport::Concern

    def versions_with_ecpm_changes
      versions.where(object_changes: nil).or(versions.where("object_changes->>'ecpm_cents' IS NOT NULL"))
    end

    # Returns a Hash of all ecpm version history
    # { Time: ecpm }
    def ecpm_history
      @ecpm_history ||= begin
        history = versions_with_ecpm_changes.select(:object).each_with_object({}) { |version, memo|
          next unless version.object
          time = Time.parse(version.object["updated_at"])
          ecpm = Money.new(version.object["ecpm_cents"], version.object["ecpm_currency"])
          memo[time] = ecpm
        }
        history[Time.current] = ecpm
        history
      end
    end

    # Returns a Hash of ecpm version history by date (last write of the day wins)
    # { Date: ecpm }
    def ecpm_history_by_date
      @ecpm_by_date ||= ecpm_history.each_with_object({}) { |(time, ecpm), memo|
        memo[time.to_date] = ecpm
      }
    end

    # Returns a Hash of applicable ecpm version history by date
    # NOTE: ecpm values aren't applicable until the next day
    # { Date: ecpm }
    def applicable_ecpm_history_by_date
      ecpm_history_by_date.each_with_object({}) do |(date, ecpm), memo|
        memo[date.advance(days: 1)] = ecpm
      end
    end

    # Returns an Array of date ranges that have unique ecpm values
    def applicable_ecpm_date_ranges
      @applicable_ecpm_date_ranges ||= begin
        list = applicable_ecpm_history_by_date.keys.concat([start_date, end_date]).sort
        ranges = []
        while list.size > 1
          current_date = list.shift
          next_date = list.first
          ranges << (current_date..next_date)
        end
        ranges
      end
    end

    # Returns a Hash of date ranges with their applicable ecpm value
    def applicable_ecpm_by_date_range
      @applicable_ecpm_by_date_range ||= begin
        applicable_ecpm_history_by_date.each_with_object({}) do |(date, ecpm), memo|
          applicable_ecpm_date_ranges.each do |date_range|
            memo[date_range] = ecpm if date_range.cover?(date)
          end
        end
      end
    end

    # Returns the ecpm value for the given date
    def applicable_ecpm_on(date, currency_iso_code = "USD")
      hit = applicable_ecpm_by_date_range.find { |(date_range, ecpm)|
        date_range.cover? date
      }
      value = hit&.last || ecpm
      value = value.exchange_to(currency_iso_code) unless value.currency.iso_code == currency_iso_code
      value
    end
  end
end
