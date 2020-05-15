class CampaignBundlesReflex < ApplicationReflex
  include CampaignBundles::Stashable

  def update_advertiser
    campaign_bundle = CampaignBundle.find(element.dataset["bundle-id"])
    return unless campaign_bundle
    request.flash[:notice] = if campaign_bundle.update(user_id: element[:value])
      "Campaign bundle updated"
    else
      "Campaign bundle could not be updated"
    end
  end

  def update_name
    campaign_bundle.name = element[:value]
  end

  def update_date_range
    campaign_bundle.date_range = element[:value]
    campaign_bundle.campaigns.each do |c|
      c.start_date = campaign_bundle.start_date
      c.end_date = campaign_bundle.end_date
    end
    campaign_bundle.init_total_budget
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
      name: "#{campaign_bundle.name} #{(temporary_id + 1).ordinalize} Campaign".strip,
      user: current_user,
      region_ids: campaign_bundle.region_ids,
      start_date: campaign_bundle.start_date,
      end_date: campaign_bundle.end_date,
      status: ENUMS::CAMPAIGN_STATUSES::ACCEPTED
    )
  end

  def remove_campaign
    campaign_bundle.campaigns.delete campaign
  end

  def update_campaign_name
    campaign.name = element[:value]
  end

  def update_campaign_date_range
    dates = element[:value].split(" - ")
    campaign.start_date = Date.strptime(dates[0], "%m/%d/%Y")
    campaign.end_date = Date.strptime(dates[1], "%m/%d/%Y")
    campaign.update_campaign_bundle_dates
    campaign_bundle.init_total_budget
    campaign_bundle.update_dates
  end

  def update_campaign_url
    campaign.url = element[:value]
  end

  def update_campaign_daily_budget
    campaign.daily_budget = Money.new(element[:value].to_f * 100, "USD")
    campaign.init_total_budget
  end

  def update_campaign_ecpm_multiplier
    campaign.ecpm_multiplier = element[:value].to_f
  end

  def update_campaign_audience_ids(audience_ids = [])
    campaign.keywords = []
    campaign.audience_ids = audience_ids.sort
  end

  def reset
    @campaign_bundle = CampaignBundle.new(
      start_date: Date.current,
      end_date: 30.days.from_now.to_date
    )
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
