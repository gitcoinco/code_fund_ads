class AdministratorDashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_administrator!

  def show
    payload = {
      resource: {dashboard: ENV["METABASE_ADMINISTRATOR_DASHBOARD_ID"].to_i},
      params: {}
    }
    token = JWT.encode payload, ENV["METABASE_SECRET_KEY"]

    @iframe_url = ENV["METABASE_SITE_URL"] + "/embed/dashboard/" + token + "#bordered=false&titled=false"
  end
end
