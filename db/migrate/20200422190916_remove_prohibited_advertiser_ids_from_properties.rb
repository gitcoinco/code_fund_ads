class RemoveProhibitedAdvertiserIdsFromProperties < ActiveRecord::Migration[6.0]
  def up
    remove_column :properties, :prohibited_advertiser_ids
  end

  def down
    add_column :properties, :prohibited_advertiser_ids, :bigint, default: [], null: false, array: true
    add_index :properties, :prohibited_advertiser_ids, using: :gin
  end
end
