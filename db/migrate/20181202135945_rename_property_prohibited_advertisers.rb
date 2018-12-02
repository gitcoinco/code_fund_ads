class RenamePropertyProhibitedAdvertisers < ActiveRecord::Migration[5.2]
  def change
    remove_index :properties, :prohibited_advertisers
    rename_column :properties, :prohibited_advertisers, :prohibited_advertiser_ids
    add_index :properties, :prohibited_advertiser_ids, using: :gin
  end
end
