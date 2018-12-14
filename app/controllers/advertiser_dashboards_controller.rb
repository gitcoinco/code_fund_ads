class AdvertiserDashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @active_campaigns = current_user.campaigns.active.order(name: :asc)
  end
end
