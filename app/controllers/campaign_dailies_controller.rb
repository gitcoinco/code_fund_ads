class CampaignDailiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_campaign

  def index
    @summary_report = @campaign.summary_report(@start_date, @end_date)
    @daily_summaries = @campaign.daily_reports(@start_date, @end_date)
    respond_to do |format|
      format.html
      format.csv do
        send_data(
          CSV.generate { |csv|
            csv << [
              "Date",
              "Spend",
              "Impressions",
              "Clicks",
              "CTR",
              "CPM",
              "CPC",
            ]
            @daily_summaries.each do |daily_summary|
              csv << [
                daily_summary.displayed_at_date.iso8601,
                daily_summary.gross_revenue,
                daily_summary.impressions_count,
                daily_summary.clicks_count,
                daily_summary.click_rate.round(2),
                daily_summary.cpm,
                daily_summary.cpc,
              ]
            end
          }
        )
      end
    end
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
