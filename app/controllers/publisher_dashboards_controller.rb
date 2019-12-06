class PublisherDashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @properties = current_user.properties.active.order("status, name")
  end
end
