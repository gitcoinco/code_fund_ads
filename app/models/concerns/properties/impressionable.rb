module Properties
  module Impressionable
    extend ActiveSupport::Concern

    def campaign_impressions_count(campaign, start_date = nil, end_date = nil)
      campaign_id = campaign.is_a?(Campaign) ? campaign.id : campaign
      relation = impressions.where(campaign_id: campaign_id)
      relation = relation.between(start_date, end_date) if start_date
      relation.count
    end

    def campaign_clicks_count(campaign, start_date = nil, end_date = nil)
      campaign_id = campaign.is_a?(Campaign) ? campaign.id : campaign
      relation = impressions.clicked.where(campaign_id: campaign_id)
      relation = relation.between(start_date, end_date) if start_date
      relation.count
    end

    def campaign_click_rate(campaign, start_date = nil, end_date = nil)
      impressions_count = campaign_impressions_count(campaign, start_date, end_date)
      return 0 if impressions_count.zero?
      clicks_count = campaign_clicks_count(campaign, start_date, end_date)
      (clicks_count / impressions_count.to_f) * 100
    end
  end
end
