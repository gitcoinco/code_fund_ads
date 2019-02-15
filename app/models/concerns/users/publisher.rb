module Users
  module Publisher
    extend ActiveSupport::Concern

    included do
      has_many :impressions_as_publisher, class_name: "Impression", foreign_key: "publisher_id"
      has_many :properties
    end

    def publisher?
      roles.include? ENUMS::USER_ROLES["publisher"]
    end

    def impressions_count_as_publisher(start_date = nil, end_date = nil)
      return 0 unless publisher?
      properties.map { |p| p.daily_impressions_counts(start_date, end_date).sum }.sum
    end

    def clicks_count_as_publisher(start_date = nil, end_date = nil)
      return 0 unless publisher?
      properties.map { |p| p.daily_clicks_counts(start_date, end_date).sum }.sum
    end

    def click_rate_as_publisher(start_date = nil, end_date = nil)
      impressions_count = impressions_count_as_publisher(start_date, end_date)
      return 0 if impressions_count.zero?
      clicks_count = clicks_count_as_publisher(start_date, end_date)
      (clicks_count / impressions_count.to_f) * 100
    end

    def calculated_gross_revenue(start_date, end_date)
      return Money.new(0, "USD") unless publisher?
      total = properties.sum { |property|
        property.calculated_gross_revenue start_date, end_date
      }
      Money.new total, "USD"
    end

    def calculated_property_revenue(start_date, end_date)
      return Money.new(0, "USD") unless publisher?
      total = properties.sum { |property|
        property.calculated_property_revenue start_date, end_date
      }
      Money.new total, "USD"
    end

    def calculated_house_revenue(start_date = nil, end_date = nil)
      return Money.new(0, "USD") unless publisher?
      total = properties.sum { |property|
        property.calculated_house_revenue start_date, end_date
      }
      Money.new total, "USD"
    end

    def estimated_gross_revenue(start_date, end_date)
      return Money.new(0, "USD") unless publisher?
      total = properties.sum { |property|
        property.estimated_gross_revenue start_date, end_date
      }
      Money.new total, "USD"
    end

    def estimated_property_revenue(start_date, end_date)
      return Money.new(0, "USD") unless publisher?
      total = properties.sum { |property|
        property.estimated_property_revenue start_date, end_date
      }
      Money.new total, "USD"
    end

    def estimated_house_revenue(start_date = nil, end_date = nil)
      return Money.new(0, "USD") unless publisher?
      total = properties.sum { |property|
        property.estimated_house_revenue start_date, end_date
      }
      Money.new total, "USD"
    end
  end
end
