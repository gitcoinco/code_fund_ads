module Campaigns
  module Impressionable
    extend ActiveSupport::Concern

    def property_impressions_count(property, start_date, end_date)
      property = Property.find(property) unless property.is_a?(Property)
      impressions_count start_date, end_date, scoped_by: property
    end

    def property_clicks_count(property, start_date, end_date)
      property = Property.find(property) unless property.is_a?(Property)
      clicks_count start_date, end_date, scoped_by: property
    end

    def property_click_rate(property, start_date, end_date)
      property = Property.find(property) unless property.is_a?(Property)
      click_rate start_date, end_date, scoped_by: property
    end
  end
end
