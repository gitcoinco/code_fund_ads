class AddHourlyBudgetToCampaigns < ActiveRecord::Migration[5.2]
  def change
    add_monetize :campaigns, :hourly_budget, default: Money.new(0, "USD"), null: false
  end
end
