class AdministratorDashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @active_campaigns = Campaign.active.premium.order(name: :asc)
    @impressions = Impression.between(@start_date, @end_date)
  end
end
