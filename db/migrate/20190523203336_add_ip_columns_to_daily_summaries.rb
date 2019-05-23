class AddIpColumnsToDailySummaries < ActiveRecord::Migration[5.2]
  def change
    add_column :daily_summaries, :unique_ip_addresses_count, :integer, default: 0, null: false
  end
end
