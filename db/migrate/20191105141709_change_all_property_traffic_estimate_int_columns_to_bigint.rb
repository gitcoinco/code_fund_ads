class ChangeAllPropertyTrafficEstimateIntColumnsToBigint < ActiveRecord::Migration[6.0]
  def up
    change_column :property_traffic_estimates, :revenue_daily_cents, :bigint
    change_column :property_traffic_estimates, :revenue_monthly_cents, :bigint
    change_column :property_traffic_estimates, :revenue_yearly_cents, :bigint
    change_column :property_traffic_estimates, :site_worth_cents, :bigint
    change_column :property_traffic_estimates, :visitors_daily, :bigint
  end

  def down
    change_column :property_traffic_estimates, :revenue_daily_cents, :integer
    change_column :property_traffic_estimates, :revenue_monthly_cents, :integer
    change_column :property_traffic_estimates, :revenue_yearly_cents, :integer
    change_column :property_traffic_estimates, :site_worth_cents, :integer
    change_column :property_traffic_estimates, :visitors_daily, :integer
  end
end
