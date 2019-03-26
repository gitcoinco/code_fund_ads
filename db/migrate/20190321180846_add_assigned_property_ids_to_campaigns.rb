class AddAssignedPropertyIdsToCampaigns < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :assigned_property_ids, :bigint, array: true, default: [], null: false
    add_index :campaigns, :assigned_property_ids, using: :gin
  end
end
