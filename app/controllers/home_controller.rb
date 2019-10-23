class HomeController < ApplicationController
  layout "home"

  def index
    report_from_date = Date.parse("2019-01-01")
    @total_impressions = DailySummaryReport.total_impressions(report_from_date)
    @total_clicks = DailySummaryReport.total_clicks(report_from_date)
    @average_ctr = @total_clicks.to_f / @total_impressions.to_f
    @butter = ButterCMS::Page.get('*', 'homepage').data.fields
  end
end
