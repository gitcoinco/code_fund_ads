class AddPropertyRevenuePercentage < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :revenue_percentage, :decimal, null: false, default: 0.5
  end
end
