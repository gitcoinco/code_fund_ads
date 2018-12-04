class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @context = params[:id]
  end

end
