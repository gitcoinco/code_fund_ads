class RemoveFixedPriceCoupon < ActiveRecord::Migration[5.2]
  def change
    remove_column :coupons, :fixed_price_currency
    remove_column :coupons, :fixed_price_cents
  end
end
