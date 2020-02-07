class CampaignFormReflex < ApplicationReflex
  include Campaigns::Stashable

  def update_audience_ids
    campaign.assign_attributes audience_ids: ids
    campaign.assign_keywords
  end

  def update_region_ids
    campaign.assign_attributes region_ids: ids
    campaign.assign_country_codes
  end

  private

  def ids
    @ids ||= element[:values].map(&:to_i)
  end

  def campaign
    @campaign ||= stashed_campaign
  end
end
