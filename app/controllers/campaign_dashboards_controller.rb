class CampaignDashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_campaign

  def show
    payload = {
      resource: {dashboard: ENV["METABASE_CAMPAIGN_DASHBOARD_ID"].to_i},
      params: {
        "campaign_id" => @campaign.id,
        "start_date" => @start_date.strftime("%F"),
        "end_date" => @end_date.strftime("%F"),
      },
    }
    token = JWT.encode payload, ENV["METABASE_SECRET_KEY"]

    @iframe_url = ENV["METABASE_SITE_URL"] + "/embed/dashboard/" + token + "#bordered=false&titled=false"
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
