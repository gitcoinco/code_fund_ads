class AddFallbackCampaignIdsToProperties < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :assigned_fallback_campaign_ids, :bigint, array: true, default: [], null: false
    add_index :properties, :assigned_fallback_campaign_ids, using: :gin
  end
end
