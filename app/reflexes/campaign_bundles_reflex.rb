class CampaignBundlesReflex < ApplicationReflex
  include CampaignBundles::Stashable

  def update_region_ids
    @campaign_bundle = stashed_campaign_bundle
    region_id = element[:value].to_i
    if element[:checked]
      @campaign_bundle.region_ids = Set.new(@campaign_bundle.region_ids + [region_id]).to_a
    else
      @campaign_bundle.region_ids.delete region_id
    end
  end
end
