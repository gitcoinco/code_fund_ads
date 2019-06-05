class AddProhibitedPropertyIdsToCampaigns < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :prohibited_property_ids, :bigint, default: [], null: false, array: true
  end
end
