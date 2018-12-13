module Campaigns
  module Impressionable
    extend ActiveSupport::Concern

    def property_impressions_count(property, start_date = nil, end_date = nil)
      property_id = property.is_a?(Property) ? property.id : property
      relation = impressions.where(property: property_id)
      relation = relation.between(start_date, end_date) if start_date
      relation.count
    end

    def property_clicks_count(property, start_date = nil, end_date = nil)
      property_id = property.is_a?(Property) ? property.id : property
      relation = impressions.clicked.where(property_id: property_id)
      relation = relation.between(start_date, end_date) if start_date
      relation.count
    end

    def property_click_rate(property, start_date = nil, end_date = nil)
      impressions_count = property_impressions_count(property, start_date, end_date)
      return 0 if impressions_count.zero?
      clicks_count = property_clicks_count(property, start_date, end_date)
      (clicks_count / impressions_count.to_f) * 100
    end
  end
end
