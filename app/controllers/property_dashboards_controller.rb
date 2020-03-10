class PropertyDashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_property

  def show
    payload = {
      resource: {dashboard: ENV["METABASE_PROPERTY_DASHBOARD_ID"].to_i},
      params: {
        "property_id" => @property.id,
        "start_date" => @start_date.strftime("%F"),
        "end_date" => @end_date.strftime("%F")
      }
    }
    token = JWT.encode payload, ENV["METABASE_SECRET_KEY"]

    @iframe_url = ENV["METABASE_SITE_URL"] + "/embed/dashboard/" + token + "#bordered=false&titled=false"
  end

  private

  def set_property
    @property = if authorized_user.can_admin_system?
      Property.find(params[:property_id])
    else
      current_user.properties.find(params[:property_id])
    end
  end
end
