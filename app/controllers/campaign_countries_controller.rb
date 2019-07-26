class CampaignCountriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_campaign

  def index
    @summary_report = @campaign.summary_report(@start_date, @end_date)
    @reports = @campaign.country_reports(@start_date, @end_date)

    respond_to do |format|
      format.html
      format.csv do
        send_data(
          CSV.generate { |csv|
            csv << [
              "Country",
              "Spend",
              "Impressions",
              "Clicks",
              "CTR",
              "CPM",
              "CPC",
            ]
            @reports.each do |report|
              country = Country.find(report.scoped_by_id)
              country_value = "#{country.name} (#{country.iso_code})" if country
              csv << [
                country_value || report.scoped_by_id,
                report.gross_revenue,
                report.impressions_count,
                report.clicks_count,
                report.click_rate.round(2),
                report.cpm,
                report.cpc,
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
