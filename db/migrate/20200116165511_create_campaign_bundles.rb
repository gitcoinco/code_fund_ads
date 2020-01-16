class CreateCampaignBundles < ActiveRecord::Migration[6.0]
  def change
    create_table :campaign_bundles do |t|
      t.string :name, null: false
      t.text :url, null: false
      t.monetize :daily_budget, null: false
      t.date :start_date
      t.date :end_date
      t.bigint :region_ids, default: [], array: true

      t.index "lower(name)", name: "index_campaign_bundles_on_name"
      t.index :end_date
      t.index :start_date
      t.index :region_ids, using: :gin
      t.timestamps
    end
  end
end
