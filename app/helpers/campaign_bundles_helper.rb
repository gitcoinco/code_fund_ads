module CampaignBundlesHelper
  def campaign_audience_dom_id(campaign, audience)
    "campaign-#{campaign.id || campaign.temporary_id}-audience-#{audience.id}"
  end
end
