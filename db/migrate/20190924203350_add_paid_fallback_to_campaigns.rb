class AddPaidFallbackToCampaigns < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :paid_fallback, :boolean, default: false
    add_index :campaigns, :paid_fallback
  end
end
