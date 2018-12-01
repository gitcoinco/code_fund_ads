class CreatePropertyAdvertisers < ActiveRecord::Migration[5.2]
  def change
    create_table :property_advertisers do |t|
      t.bigint :property_id, null: false
      t.bigint :advertiser_id, null: false
      t.date :displayed_at_date, null: false
      t.timestamps

      t.index [:property_id]
      t.index [:advertiser_id]
      t.index [:displayed_at_date]
      t.index [:property_id, :advertiser_id, :displayed_at_date], unique: true, name: "index_property_advertisers_unique"
    end
  end
end
