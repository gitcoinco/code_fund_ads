class AdministratorDashboardsController < ApplicationController
  include Sortable

  before_action :authenticate_user!
  before_action :authenticate_administrator!
  before_action :set_sortable_columns

  def show
    campaigns = Campaign.active.premium.includes(:organization).order(order_by)
    @pagy, @campaigns = pagy(campaigns, items: Pagy::VARS[:items])
  end

  def set_sortable_columns
    @sortable_columns ||= sortable_columns
  end

  private

  def sortable_columns
    %w[
      start_date
      end_date
      name
      updated_at
      created_at
      hourly_budget_cents
      daily_budget_cents
      total_budget_cents
    ]
  end
end
