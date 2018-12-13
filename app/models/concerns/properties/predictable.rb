module Properties
  module Predictable
    extend ActiveSupport::Concern

    def estimated_gross_revenue(start_date = nil, end_date = nil)
      relation = impressions
      relation = relation.between(start_date, end_date) if start_date
      cents = relation.sum(:estimated_gross_revenue_fractional_cents)
      Money.new cents, "USD"
    end


    def estimated_property_revenue(start_date = nil, end_date = nil)
      relation = impressions
      relation = relation.between(start_date, end_date) if start_date
      cents = relation.sum(:estimated_property_revenue_fractional_cents)
      Money.new cents, "USD"
    end

    def estimated_house_revenue(start_date = nil, end_date = nil)
      relation = impressions
      relation = relation.between(start_date, end_date) if start_date
      cents = relation.sum(:estimated_house_revenue_fractional_cents)
      Money.new cents, "USD"
    end
  end
end
