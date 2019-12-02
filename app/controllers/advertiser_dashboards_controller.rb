class AdvertiserDashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @campaigns = current_user.campaigns.where(status: ["pending", "active"]).order(name: :asc)
  end
end
