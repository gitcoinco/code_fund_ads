class CampaignTargetingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_campaign

  def show
  end

  private

  def set_campaign
    @campaign = if authorized_user.can_admin_system?
      Campaign.find(params[:campaign_id])
    else
      Current.organization&.campaigns&.find(params[:campaign_id])
    end
  end
end
