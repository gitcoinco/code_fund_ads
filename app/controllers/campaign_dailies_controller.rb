class CampaignDailiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_campaign

  def index
    @summary = @campaign.summary(@start_date, @end_date)
    @daily_summaries = @campaign.daily_summaries_by_day(@start_date, @end_date)
    respond_to do |format|
      format.html
      format.csv do
        send_data(
          @campaign.daily_csv(@start_date, @end_date),
          filename: "campaign-daily-report-#{@campaign.id}-#{@start_date.to_s("yyyymmdd")}-#{@end_date.to_s("yyyymmdd")}.csv"
        )
      end
    end
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
