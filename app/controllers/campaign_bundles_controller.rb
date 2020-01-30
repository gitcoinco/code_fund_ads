class CampaignBundlesController < ApplicationController
  include CampaignBundles::Stashable
  before_action :authenticate_user!
  layout "demo"

  def new
    @campaign_bundle ||= stashed_campaign_bundle
    @campaign_bundle.assign_attributes organization: Current.organization, user: current_user
    @campaign_bundle.start_date ||= Date.current
    @campaign_bundle.validate
    @campaign_bundle.errors.each do |key, _|
      @campaign_bundle.errors.delete key if key.to_s.start_with?("campaign")
    end
    stash_campaign_bundle @campaign_bundle
  end

  def create
    binding.pry
  end
end
