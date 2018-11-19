class AccountsReceivable < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :total_impressions_count, :integer, default: 0, null: false
  end
end
