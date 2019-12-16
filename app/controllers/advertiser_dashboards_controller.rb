class AdvertiserDashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @campaigns = Current.organization&.campaigns&.where(status: ["pending", "active"])&.order(name: :asc)
  end
end
