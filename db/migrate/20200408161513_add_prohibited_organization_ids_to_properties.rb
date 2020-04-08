class AddProhibitedOrganizationIdsToProperties < ActiveRecord::Migration[6.0]
  def change
    add_column :properties, :prohibited_organization_ids, :bigint, default: [], null: false, array: true
    add_index :properties, :prohibited_organization_ids, using: :gin
  end
end
