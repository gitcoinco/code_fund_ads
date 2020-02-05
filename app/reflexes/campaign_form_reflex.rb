class CampaignFormReflex < ApplicationReflex
  def update_keywords(audience_ids)
    @audiences = Audience.where(id: audience_ids)
  end

  def update_geo_targeting(region_ids)
    @regions = Region.where(id: region_ids)
  end
end
