class PublisherDashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    # @properties = current_user.properties.active.includes(:screenshot_attachment).order("status, name")

    payload = {
      resource: {
        dashboard: ENV["METABASE_PUBLISHER_DASHBOARD_ID"].to_i,
      },
      params: {
        "publisher_id" => current_user.id,
        "date_filter" => "#{@start_date.strftime("%F")}~#{@end_date.strftime("%F")}",
      },
    }
    token = JWT.encode payload, ENV["METABASE_SECRET_KEY"]

    @iframe_url = ENV["METABASE_SITE_URL"] + "/embed/dashboard/" + token + "#bordered=false&titled=false"
  end
end
