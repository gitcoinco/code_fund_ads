class CreateDailySummaries < ActiveRecord::Migration[5.2]
  def change
    create_table :daily_summaries do |t|
      t.string :record_type, null: false
      t.bigint :record_id, null: false
      t.integer :count, null: false, default: 0
      t.monetize :average_ecpm, null: false, default: Money.new(0, "USD")
      t.monetize :estimated_gross_revenue, null: false, default: Money.new(0, "USD")
      t.monetize :estimated_property_revenue, null: false, default: Money.new(0, "USD")
      t.monetize :estimated_house_revenue, null: false, default: Money.new(0, "USD")
      t.date :displayed_at_date, null: false
      t.timestamps

      t.index [:record_type, :record_id]
      t.index :displayed_at_date
    end
  end
end
