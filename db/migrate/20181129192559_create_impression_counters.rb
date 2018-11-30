class CreateImpressionCounters < ActiveRecord::Migration[5.2]
  def change
    create_table :impression_counters do |t|
      t.bigint :campaign_id, null: false
      t.bigint :property_id, null: false
      t.date :displayed_at_date, null: false
      t.bigint :count, null: false, default: 0
      t.timestamps

      t.index :campaign_id
      t.index :property_id
      t.index :displayed_at_date
      t.index [:campaign_id, :property_id, :displayed_at_date], unique: true, name: "index_impression_counters_uniqueness"
    end
  end
end
