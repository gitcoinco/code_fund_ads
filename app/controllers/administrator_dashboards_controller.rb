class AdministratorDashboardsController < ApplicationController
  include Scopable
  include Sortable
  
  before_action :authenticate_administrator!

  def show
    campaigns = Campaign.active.premium.order(name: :asc).includes(:organization)

    max = (campaigns.count / Pagy::VARS[:items].to_f).ceil
    @pagy, @campaigns = pagy(campaigns, page: current_page(max: max))
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
end
