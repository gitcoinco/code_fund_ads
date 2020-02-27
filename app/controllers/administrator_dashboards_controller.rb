class AdministratorDashboardsController < ApplicationController
  include Sortable

  before_action :authenticate_user!
  before_action :authenticate_administrator!

  def show
    campaigns = Campaign.active.premium.includes(:organization).order(order_by)
    @pagy, @campaigns = pagy(campaigns, items: Pagy::VARS[:items])
  end

  private

  def sortable_columns
    %w[
      start_date
      end_date
      name
      status
      updated_at
    ]
  end

  def sort_column
    return params[:column] if sortable_columns.include?(params[:column])
    "name"
  end
end
