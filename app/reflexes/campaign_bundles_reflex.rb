class CampaignBundlesReflex < ApplicationReflex
  include CampaignBundles::Stashable

  def update_start_date
    campaign_bundle.start_date = Date.parse(element[:value])
  rescue => e
    Rails.logger.error "Failed to parse and assign CampaignBundle#start_date! #{e}"
  end

  def update_end_date
    campaign_bundle.end_date = Date.parse(element[:value])
  rescue => e
    Rails.logger.error "Failed to parse and assign CampaignBundle#end_date! #{e}"
  end

  def update_region_ids(region_ids = [])
    campaign_bundle.region_ids = region_ids.sort
  end

  def select_all_region_ids
    update_region_ids Region.all.pluck(:id)
  end

  private

  def campaign_bundle
    @campaign_bundle ||= stashed_campaign_bundle
  end
end
