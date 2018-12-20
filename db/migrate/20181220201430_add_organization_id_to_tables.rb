class AddOrganizationIdToTables < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :organization_id, :bigint
    add_column :campaigns, :organization_id, :bigint
    add_column :creatives, :organization_id, :bigint
    add_column :impressions, :organization_id, :bigint

    add_index :users, :organization_id
    add_index :campaigns, :organization_id
    add_index :creatives, :organization_id
    add_index :impressions, :organization_id
  end
end
