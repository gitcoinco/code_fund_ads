class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :assign_dates

  def show
    @context = params[:id]
  end

  private

  def assign_dates
    @start_date = Date.current.beginning_of_month
    @end_date = Date.current

    if params[:date_range].present?
      dates = params[:date_range].split(" - ")
      @start_date = Date.strptime(dates[0], "%m/%d/%Y")
      @end_date   = Date.strptime(dates[1], "%m/%d/%Y")
    end
  end

end
