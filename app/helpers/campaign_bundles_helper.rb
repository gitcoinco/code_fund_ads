module CampaignBundlesHelper
  def campaign_audience_dom_id(campaign, audience)
    "campaign-#{campaign.id || campaign.temporary_id}-audience-#{audience.id}"
  end

  def campaign_bundle_status_color(status)
    ENUMS::CAMPAIGN_BUNDLE_STATUS_COLORS[status]
  end
end
