class CampaignFormReflex < ApplicationReflex
  include Campaigns::Stashable

  def update_audience_ids
    if persisted_campaign
      persisted_campaign.update audience_ids: ids
    else
      new_campaign.assign_attributes audience_ids: ids
      new_campaign.assign_keywords
      stash_campaign(new_campaign)
    end
  end

  def update_region_ids
    if persisted_campaign
      persisted_campaign.update region_ids: ids
    else
      new_campaign.assign_attributes region_ids: ids
      new_campaign.assign_country_codes
      stash_campaign(new_campaign)
    end
  end

  private

  def ids
    @ids ||= element[:values].map(&:to_i)
  end

  def new_campaign
    @new_campaign ||= stashed_campaign
  end

  def persisted_campaign
    @persisted_campaign ||= Campaign.find_by id: element.dataset["campaign-id"].to_i
  end
end
