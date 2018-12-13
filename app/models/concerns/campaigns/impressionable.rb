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
  end
end
