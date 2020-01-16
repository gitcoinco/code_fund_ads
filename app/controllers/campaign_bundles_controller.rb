class CampaignBundlesController < ApplicationController
  before_action :authenticate_user!
  layout "demo"

  def new
    @campaign_bundle = CampaignBundle.new(
      start_date: Date.current.to_s("mm/dd/yyyy"),
      region_ids: [Region.americas_northern.id],
    )
  end
end
