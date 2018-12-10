class AddLegacyIdToModels < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :legacy_id, :uuid
    add_column :campaigns, :legacy_id, :uuid
    add_column :creatives, :legacy_id, :uuid
    add_column :properties, :legacy_id, :uuid
  end
end
