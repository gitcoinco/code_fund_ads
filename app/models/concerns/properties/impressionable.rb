module Properties
  module Impressionable
    extend ActiveSupport::Concern

    def campaign_impressions_count(campaign, start_date, end_date)
      campaign = Campaign.find(campaign) unless campaign.is_a?(Campaign)
      impressions_count start_date, end_date, scoped_by: campaign
    end

    def campaign_clicks_count(campaign, start_date, end_date)
      campaign = Campaign.find(campaign) unless campaign.is_a?(Campaign)
      clicks_count start_date, end_date, scoped_by: campaign
    end

    def campaign_click_rate(campaign, start_date, end_date)
      campaign = Campaign.find(campaign) unless campaign.is_a?(Campaign)
      click_rate start_date, end_date, scoped_by: campaign
    end

    def campaign_property_revenue(campaign, start_date, end_date)
      campaign = Campaign.find(campaign) unless campaign.is_a?(Campaign)
      property_revenue start_date, end_date, scoped_by: campaign
    end
  end
end
