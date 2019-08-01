class CampaignReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_campaign

  def create
    CampaignReportsMailer.campaign_report(@campaign, @start_date, @end_date).deliver_later
    head :ok
  end

  private

  def set_campaign
    @campaign = if authorized_user.can_admin_system?
      Campaign.find(params[:campaign_id])
    else
      current_user.campaigns.find(params[:campaign_id])
    end
  end
end
