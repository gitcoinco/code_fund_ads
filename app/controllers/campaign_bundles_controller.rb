class CampaignBundlesController < ApplicationController
  include CampaignBundles::Stashable
  before_action :authenticate_user!
  layout "demo"

  def new
    @campaign_bundle ||= stashed_campaign_bundle
    @campaign_bundle.assign_attributes organization: Current.organization, user: current_user
    @campaign_bundle.start_date ||= Date.current
    stash_campaign_bundle @campaign_bundle
  end
end
