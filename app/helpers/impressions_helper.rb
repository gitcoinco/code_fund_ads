module ImpressionsHelper
  def estimated_property_revenue(impressions_relation)
    Money.new(impressions_relation.sum(:estimated_property_revenue_fractional_cents), "USD")
  end
end
