class AdministratorDashboardsController < ApplicationController
  include Dateable

  before_action :authenticate_user!

  def show
    @active_advertisers = User.advertisers.with_active_campaigns.order(company_name: :asc)
    @active_campaigns = Campaign.active.order(name: :asc)
  end
end
