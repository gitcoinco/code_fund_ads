class CampaignEstimatesController < ApplicationController
  before_action :authenticate_administrator!
  before_action :set_campaign, only: :show

  def show
    @campaign_bundle = @campaign.campaign_bundle
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end
end
