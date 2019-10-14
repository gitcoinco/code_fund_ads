class ChangePropertyTrafficEstimateIntColumnsToBigint < ActiveRecord::Migration[6.0]
  def up
    change_column :property_traffic_estimates, :visitors_monthly, :bigint
    change_column :property_traffic_estimates, :visitors_yearly, :bigint
    change_column :property_traffic_estimates, :pageviews_daily, :bigint
    change_column :property_traffic_estimates, :pageviews_monthly, :bigint
    change_column :property_traffic_estimates, :pageviews_yearly, :bigint
    change_column :property_traffic_estimates, :alexa_rank_3_months, :bigint
    change_column :property_traffic_estimates, :alexa_rank_1_month, :bigint
    change_column :property_traffic_estimates, :alexa_rank_7_days, :bigint
    change_column :property_traffic_estimates, :alexa_rank_1_day, :bigint
    change_column :property_traffic_estimates, :alexa_rank_delta_3_months, :bigint
    change_column :property_traffic_estimates, :alexa_rank_delta_1_month, :bigint
    change_column :property_traffic_estimates, :alexa_rank_delta_7_days, :bigint
    change_column :property_traffic_estimates, :alexa_rank_delta_1_day, :bigint
    change_column :property_traffic_estimates, :alexa_reach_3_months, :bigint
    change_column :property_traffic_estimates, :alexa_reach_1_month, :bigint
    change_column :property_traffic_estimates, :alexa_reach_7_days, :bigint
    change_column :property_traffic_estimates, :alexa_reach_1_day, :bigint
    change_column :property_traffic_estimates, :alexa_reach_delta_3_months, :bigint
    change_column :property_traffic_estimates, :alexa_reach_delta_1_month, :bigint
    change_column :property_traffic_estimates, :alexa_reach_delta_7_days, :bigint
    change_column :property_traffic_estimates, :alexa_reach_delta_1_day, :bigint
  end

  def down
    change_column :property_traffic_estimates, :visitors_monthly, :integer
    change_column :property_traffic_estimates, :visitors_yearly, :integer
    change_column :property_traffic_estimates, :pageviews_daily, :integer
    change_column :property_traffic_estimates, :pageviews_monthly, :integer
    change_column :property_traffic_estimates, :pageviews_yearly, :integer
    change_column :property_traffic_estimates, :alexa_rank_3_months, :integer
    change_column :property_traffic_estimates, :alexa_rank_1_month, :integer
    change_column :property_traffic_estimates, :alexa_rank_7_days, :integer
    change_column :property_traffic_estimates, :alexa_rank_1_day, :integer
    change_column :property_traffic_estimates, :alexa_rank_delta_3_months, :integer
    change_column :property_traffic_estimates, :alexa_rank_delta_1_month, :integer
    change_column :property_traffic_estimates, :alexa_rank_delta_7_days, :integer
    change_column :property_traffic_estimates, :alexa_rank_delta_1_day, :integer
    change_column :property_traffic_estimates, :alexa_reach_3_months, :integer
    change_column :property_traffic_estimates, :alexa_reach_1_month, :integer
    change_column :property_traffic_estimates, :alexa_reach_7_days, :integer
    change_column :property_traffic_estimates, :alexa_reach_1_day, :integer
    change_column :property_traffic_estimates, :alexa_reach_delta_3_months, :integer
    change_column :property_traffic_estimates, :alexa_reach_delta_1_month, :integer
    change_column :property_traffic_estimates, :alexa_reach_delta_7_days, :integer
    change_column :property_traffic_estimates, :alexa_reach_delta_1_day, :integer
  end
end
