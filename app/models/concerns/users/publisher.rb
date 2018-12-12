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

    def gross_revenue(start_date = nil, end_date = nil)
      return Money.new(0, "USD") unless publisher?
      properties.sum do |property|
        property.gross_revenue start_date, end_date
      end
    end

    def earned_revenue(start_date = nil, end_date = nil)
      return Money.new(0, "USD") unless publisher?
      properties.sum do |property|
        property.property_revenue start_date, end_date
      end
    end

    def house_revenue(start_date = nil, end_date = nil)
      return Money.new(0, "USD") unless publisher?
      properties.sum do |property|
        property.house_revenue start_date, end_date
      end
    end
  end
end
