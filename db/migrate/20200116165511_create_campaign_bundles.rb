class CreateCampaignBundles < ActiveRecord::Migration[6.0]
  def change
    create_table :campaign_bundles do |t|
      t.bigint :organization_id, null: false
      t.bigint :user_id, null: false
      t.string :name, null: false
      t.date :start_date
      t.date :end_date
      t.bigint :region_ids, default: [], array: true

      t.index "lower(name)", name: "index_campaign_bundles_on_name"
      t.index :end_date
      t.index :start_date
      t.index :region_ids, using: :gin
      t.timestamps
    end

    add_column :campaigns, :campaign_bundle_id, :bigint
    add_column :campaigns, :audience_ids, :bigint, default: [], array: true, null: false
    add_column :campaigns, :region_ids, :bigint, default: [], array: true, null: false
    add_column :campaigns, :ecpm_multiplier, :decimal, default: 1, null: false
    add_index :campaigns, :campaign_bundle_id
    add_index :campaigns, :audience_ids, using: :gin
    add_index :campaigns, :region_ids, using: :gin
  end
end
