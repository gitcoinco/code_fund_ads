class CreatePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :pricing_plans do |t|
      t.string :name, null: false
      t.timestamps
      t.index :name, unique: true
    end

    create_table :prices do |t|
      t.bigint :pricing_plan_id, null: false
      t.bigint :audience_id, null: false
      t.bigint :region_id, null: false
      t.monetize :cpm, null: false, default: Money.new(0, "USD")
      t.monetize :rpm, null: false, default: Money.new(0, "USD")
      t.timestamps

      t.index :audience_id
      t.index :region_id
      t.index [:pricing_plan_id, :audience_id, :region_id], unique: true
    end
  end
end
