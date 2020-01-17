class CampaignBundlesReflex < ApplicationReflex
  include CampaignBundles::Stashable

  def update_region_ids(region_ids = [])
    @campaign_bundle = stashed_campaign_bundle
    @campaign_bundle.region_ids = region_ids.sort
  end

  def select_all_region_ids
    update_region_ids Region.all.pluck(:id)
  end
end
