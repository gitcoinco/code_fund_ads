class AddProhibitedPropertyIdsToCampaigns < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :prohibited_property_ids, :bigint, default: [], null: false, array: true
    add_index :campaigns, :prohibited_property_ids, using: :gin
  end
end
