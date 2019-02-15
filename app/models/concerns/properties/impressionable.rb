module Properties
  module Impressionable
    extend ActiveSupport::Concern

    def campaign_impressions_count(campaign, start_date, end_date)
      campaign_id = campaign.is_a?(Campaign) ? campaign.id : campaign
      impressions.between(start_date, end_date).where(campaign_id: campaign_id).count
    end

    def campaign_clicks_count(campaign, start_date, end_date)
      campaign_id = campaign.is_a?(Campaign) ? campaign.id : campaign
      impressions.clicked.between(start_date, end_date).where(campaign_id: campaign_id).count
    end

    def campaign_click_rate(campaign, start_date, end_date)
      impressions_count = campaign_impressions_count(campaign, start_date, end_date)
      return 0 if impressions_count.zero?
      clicks_count = campaign_clicks_count(campaign, start_date, end_date)
      (clicks_count / impressions_count.to_f) * 100
    end
  end
end
