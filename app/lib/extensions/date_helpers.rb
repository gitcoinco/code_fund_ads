module Extensions
  module DateHelpers
    extend ActiveSupport::Concern

    module ClassMethods
      # Casts the passed value to a Date
      # Returns nil if the value cannot be cast
      def cast(value)
        case value
        when Date then value
        when Time, DateTime, ActiveSupport::TimeWithZone then return value.to_date
        else begin
               Date.parse(value.to_s)
             rescue
               nil
             end
        end
      end

      # Returns a Date representation of the passed value regardless of whether or not the value is a legit date
      # nil == Date.current
      # "invalid" == Date.current
      def coerce(value)
        cast(value) || Date.current
      end

      def cache_key(date, coerce: true, minutes_cached: 5)
        return nil unless date || coerce
        date = Date.coerce(date)
        return date.iso8601 if date.past?
        minute_groups = (1..60).each_slice(minutes_cached).to_a
        index = minute_groups.index { |set| set.include?(Time.current.min) }
        "#{date.iso8601}/#{Time.current.hour}#{index}"
      end
    end

    def cache_key(minutes_cached: 5)
      Date.cache_key self, coerce: false, minutes_cached: minutes_cached
    end
  end
end
