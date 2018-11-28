class CampaignBudgetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_campaign

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end
end
