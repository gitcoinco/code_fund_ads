class CreateDailySummaries < ActiveRecord::Migration[5.2]
  def change
    create_table :daily_summaries do |t|
      t.string :impressionable_type, null: false
      t.bigint :impressionable_id, null: false
      t.string :scoped_by_type
      t.bigint :scoped_by_id
      t.integer :impressions_count, null: false, default: 0
      t.integer :clicks_count, null: false, default: 0
      t.decimal :click_rate, null: false, default: 0
      t.monetize :ecpm, null: false, default: Money.new(0, "USD")
      t.monetize :estimated_gross_revenue, null: false, default: Money.new(0, "USD")
      t.monetize :estimated_property_revenue, null: false, default: Money.new(0, "USD")
      t.monetize :estimated_house_revenue, null: false, default: Money.new(0, "USD")
      t.date :displayed_at_date, null: false
      t.timestamps

      t.index [:impressionable_type, :impressionable_id], name: "index_daily_summaries_on_impressionable_columns"
      t.index [:scoped_by_type, :scoped_by_id], name: "index_daily_summaries_on_scoped_by_columns"
      t.index :displayed_at_date
    end
  end
end
