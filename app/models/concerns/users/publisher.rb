module Users
  module Publisher
    extend ActiveSupport::Concern

    included do
      has_many :properties
    end

    def publisher?
      roles.include? ENUMS::USER_ROLES["publisher"]
    end

    def impressions_count_as_publisher(start_date = nil, end_date = nil)
      return 0 unless publisher?
      properties.map { |p| p.impressions_count(start_date, end_date) }.sum
    end

    def clicks_count_as_publisher(start_date = nil, end_date = nil)
      return 0 unless publisher?
      properties.map { |p| p.clicks_count(start_date, end_date) }.sum
    end

    def click_rate_as_publisher(start_date = nil, end_date = nil)
      impressions_count = impressions_count_as_publisher(start_date, end_date)
      return 0 if impressions_count.zero?
      clicks_count = clicks_count_as_publisher(start_date, end_date)
      (clicks_count / impressions_count.to_f) * 100
    end

    def gross_revenue(start_date, end_date)
      Monetize.parse(properties.active.sum { |p| p.gross_revenue(start_date, end_date) })
    end

    def property_revenue(start_date, end_date)
      Monetize.parse(properties.active.sum { |p| p.property_revenue(start_date, end_date) })
    end

    def house_revenue(start_date, end_date)
      Monetize.parse(properties.active.sum { |p| p.house_revenue(start_date, end_date) })
    end
  end
end
