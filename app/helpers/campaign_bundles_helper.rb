module CampaignBundlesHelper
  def campaign_audience_dom_id(campaign, audience)
    "campaign-#{campaign.id || campaign.temporary_id}-audience-#{audience.id}"
  end

  def estimated_impressions_count(campaign_bundle)
    campaign_bundle.campaigns.sum do |campaign|
      campaign.inventory_summary.estimated_impressions_count
    end
  end

  def estimated_clicks_count(campaign_bundle)
    campaign_bundle.campaigns.sum do |campaign|
      campaign.inventory_summary.estimated_clicks_count
    end
  end

  def estimated_cpm(campaign_bundle)
    impressions_count = estimated_impressions_count(campaign_bundle)
    return Money.new(0) unless impressions_count > 0
    campaign_bundle.total_budget / (impressions_count / 1000.to_f)
  end

  def estimated_cpc(campaign_bundle)
    clicks_count = estimated_clicks_count(campaign_bundle)
    return Money.new(0) unless clicks_count > 0
    campaign_bundle.total_budget / clicks_count
  end
end
