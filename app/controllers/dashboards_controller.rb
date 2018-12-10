class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :assign_dates

  def show
    @context = params[:id]

    @active_advertisers = User.advertisers.with_active_campaigns.order(company_name: :asc)
    @active_campaigns = Campaign.active.order(name: :asc)
  end

  private

  def assign_dates
    @start_date = session[:start_date].present? ?
      Date.strptime(session[:start_date], "%m/%d/%Y") :
      Date.current.beginning_of_month

    @end_date = session[:end_date].present? ?
      Date.strptime(session[:end_date], "%m/%d/%Y") :
      Date.current

    if params[:date_range].present?
      dates = params[:date_range].split(" - ")
      @start_date = Date.strptime(dates[0], "%m/%d/%Y")
      @end_date   = Date.strptime(dates[1], "%m/%d/%Y")
    end

    session[:start_date] = @start_date.to_s("mm/dd/yyyy")
    session[:end_date]   = @end_date.to_s("mm/dd/yyyy")
  end
end
