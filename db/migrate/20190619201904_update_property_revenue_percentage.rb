class UpdatePropertyRevenuePercentage < ActiveRecord::Migration[5.2]
  def change
    change_column :properties, :revenue_percentage, :decimal, null: false, default: 0.6
  end
end
