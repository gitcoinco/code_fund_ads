class AdministratorDashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @active_campaigns = Campaign.active.order(name: :asc).limit(9)
    @impressions_count = Impression.between(@start_date, @end_date).count
    @clicks_count = Impression.clicked.between(@start_date, @end_date).count
    @average_click_rate = if @impressions_count > 0
      (@clicks_count / @impressions_count.to_f) * 100
    else
      0.0
    end
    @total_revenue = Money.new 0, "USD"
    @total_distributions = Money.new 0, "USD"
    @total_profit = Money.new 0, "USD"
  end
end
