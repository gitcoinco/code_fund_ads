class CampaignFormReflex < ApplicationReflex
  include Campaigns::Stashable

  def update_audience_ids
    campaign.assign_attributes audience_ids: element[:values].map(&:to_i)
    campaign.assign_keywords force_audience_keywords: true
  end

  def update_region_ids
    campaign.assign_attributes region_ids: element[:values].map(&:to_i)
    campaign.assign_country_codes force_region_country_codes: true
  end

  private

  def campaign
    @campaign ||= stashed_campaign
  end
end
