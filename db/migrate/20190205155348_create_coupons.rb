class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :code, null: false
      t.string :description
      t.string :coupon_type, null: false
      t.integer :discount_percent, null: false, default: 0
      t.monetize :fixed_price, null: false, default: Money.new(99999, "USD")
      t.timestamp :expires_at, null: false
      t.integer :quantity, null: false, default: 99999
      t.integer :claimed, null: false, default: 0

      t.index :code, unique: true

      t.timestamps
    end
  end
end
