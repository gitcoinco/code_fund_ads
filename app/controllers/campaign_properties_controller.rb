class CampaignPropertiesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_administrator!, only: [:update]
  before_action :set_campaign

  def index
    @summary = @campaign.summary(@start_date, @end_date)
    @reports = @campaign.daily_summary_reports_by_property(@start_date, @end_date)

    respond_to do |format|
      format.html
      format.csv do
        send_data(
          @campaign.property_csv(@start_date, @end_date),
          filename: "campaign-property-report-#{@campaign.id}-#{@start_date.to_s("yyyymmdd")}-#{@end_date.to_s("yyyymmdd")}.csv"
        )
      end
    end
  end

  def update
    property_id = params[:id]
    if params[:campaign_property][:checked]
      @campaign.prohibit_property!(property_id)
    else
      @campaign.permit_property!(property_id)
    end
    render json: {ok: true}, status: :ok
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
