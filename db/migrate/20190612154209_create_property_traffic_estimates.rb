class CreatePropertyTrafficEstimates < ActiveRecord::Migration[5.2]
  def change
    create_table :property_traffic_estimates do |t|
      t.bigint :property_id, null: false
      t.monetize :site_worth, null: false, default: Money.new(0, "USD")
      t.integer :visitors_daily, default: 0
      t.integer :visitors_monthly, default: 0
      t.integer :visitors_yearly, default: 0
      t.integer :pageviews_daily, default: 0
      t.integer :pageviews_monthly, default: 0
      t.integer :pageviews_yearly, default: 0
      t.monetize :revenue_daily, null: false, default: Money.new(0, "USD")
      t.monetize :revenue_monthly, null: false, default: Money.new(0, "USD")
      t.monetize :revenue_yearly, null: false, default: Money.new(0, "USD")
      t.integer :alexa_rank_3_months, default: 0
      t.integer :alexa_rank_1_month, default: 0
      t.integer :alexa_rank_7_days, default: 0
      t.integer :alexa_rank_1_day, default: 0
      t.integer :alexa_rank_delta_3_months, default: 0
      t.integer :alexa_rank_delta_1_month, default: 0
      t.integer :alexa_rank_delta_7_days, default: 0
      t.integer :alexa_rank_delta_1_day, default: 0
      t.integer :alexa_reach_3_months, default: 0
      t.integer :alexa_reach_1_month, default: 0
      t.integer :alexa_reach_7_days, default: 0
      t.integer :alexa_reach_1_day, default: 0
      t.integer :alexa_reach_delta_3_months, default: 0
      t.integer :alexa_reach_delta_1_month, default: 0
      t.integer :alexa_reach_delta_7_days, default: 0
      t.integer :alexa_reach_delta_1_day, default: 0
      t.float :alexa_pageviews_3_months
      t.float :alexa_pageviews_1_month
      t.float :alexa_pageviews_7_days
      t.float :alexa_pageviews_1_day
      t.float :alexa_pageviews_delta_3_months
      t.float :alexa_pageviews_delta_1_month
      t.float :alexa_pageviews_delta_7_days
      t.float :alexa_pageviews_delta_1_day
      t.index :property_id
      t.timestamps
    end
  end
end
