module Extensions
  module DateHelpers
    extend ActiveSupport::Concern

    module ClassMethods
      # Casts the passed value to a Date
      # Returns nil if the value cannot be cast
      def cast(value)
        case value
        when Date then return value
        when Time, DateTime, ActiveSupport::TimeWithZone then return value.to_date
        else Date.parse(value.to_s) rescue nil
        end
      end

      # Returns a Date representation of the passed value regardless of whether or not the value is a legit date
      # nil == Date.current
      # "invalid" == Date.current
      def coerce(value)
        cast(value) || Date.current
      end
    end
  end
end
