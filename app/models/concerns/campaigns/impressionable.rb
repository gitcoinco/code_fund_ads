module Campaigns
  module Impressionable
    extend ActiveSupport::Concern

    def property_impressions_count(property, start_date, end_date)
      property_id = property.is_a?(Property) ? property.id : property
      impressions.between(start_date, end_date).where(property: property_id).count
    end

    def property_clicks_count(property, start_date, end_date)
      property_id = property.is_a?(Property) ? property.id : property
      impressions.clicked.between(start_date, end_date).where(property_id: property_id).count
    end

    def property_click_rate(property, start_date, end_date)
      impressions_count = property_impressions_count(property, start_date, end_date)
      return 0 if impressions_count.zero?
      clicks_count = property_clicks_count(property, start_date, end_date)
      (clicks_count / impressions_count.to_f) * 100
    end
  end
end
