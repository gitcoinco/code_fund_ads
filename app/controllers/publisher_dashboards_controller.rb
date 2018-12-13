class PublisherDashboardsController < ApplicationController
  include Dateable

  before_action :authenticate_user!

  def show
    @properties = current_user.properties.order("status, name")
  end
end
