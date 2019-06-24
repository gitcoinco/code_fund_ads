class AddAlternateCreativeIdsToCampaign < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :creative_ids, :bigint, default: [], null: false, array: true
    add_index :campaigns, :creative_ids, using: :gin
  end
end
