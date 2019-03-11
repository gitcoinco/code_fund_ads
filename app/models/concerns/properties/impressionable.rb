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

    def campaign_estimated_property_revenue(campaign, start_date, end_date)
      campaign_id = campaign.is_a?(Campaign) ? campaign.id : campaign
      key = "#{cache_key}/#{__method__}/#{campaign_id}/#{Date.coerce(start_date).cache_key minutes_cached: 15}-#{Date.coerce(end_date).cache_key minutes_cached: 15}"
      cents = Rails.cache.fetch(key) {
        impressions.where(campaign_id: campaign_id).between(start_date, end_date).sum(:estimated_property_revenue_fractional_cents).round
      }.to_i
      Money.new cents, "USD"
    end
  end
end
