class CampaignBundlesReflex < ApplicationReflex
  include CampaignBundles::Stashable

  def update_start_date
    campaign_bundle.start_date = Date.parse(element[:value])
    campaign_bundle.campaigns.each do |campaign|
      campaign.start_date = campaign_bundle.start_date
    end
  rescue => e
    Rails.logger.error "Failed to parse and assign CampaignBundle#start_date! #{e}"
  end

  def update_end_date
    campaign_bundle.end_date = Date.parse(element[:value])
    campaign_bundle.campaigns.each do |campaign|
      campaign.end_date = campaign_bundle.end_date
    end
  rescue => e
    Rails.logger.error "Failed to parse and assign CampaignBundle#end_date! #{e}"
  end

  def update_region_ids(region_ids = [])
    campaign_bundle.region_ids = region_ids.sort
    campaign_bundle.campaigns.each do |campaign|
      campaign.region_ids = campaign_bundle.region_ids
    end
  end

  def add_campaign
    temporary_id = campaign_bundle.campaigns.size
    campaign_bundle.campaigns.build(
      temporary_id: temporary_id,
      name: "#{(temporary_id + 1).ordinalize} Campaign",
      user: current_user,
      region_ids: campaign_bundle.region_ids,
      start_date: campaign_bundle.start_date,
      end_date: campaign_bundle.end_date,
      status: ENUMS::CAMPAIGN_STATUSES::PENDING,
    )
  end

  def remove_campaign
    campaign_bundle.campaigns.delete campaign
  end

  def update_campaign_audience_ids(audience_ids = [])
    campaign.audience_ids = audience_ids.sort
  end

  private

  def campaign_bundle
    @campaign_bundle ||= stashed_campaign_bundle
  end

  def campaign
    @campaign ||= begin
      temporary_id = element.dataset["temporary-id"].to_i
      campaign_bundle.campaigns.find { |c| c.temporary_id == temporary_id }
    end
  end
end
