class CreatePixelConversions < ActiveRecord::Migration[6.0]
  def change
    create_table :pixel_conversions do |t|
      t.uuid :pixel_id, null: false
      t.uuid :impression_id
      t.string :impression_id_param, null: false, default: ""
      t.boolean :test, null: false, default: false
      t.string :pixel_name, null: false, default: ""
      t.monetize :pixel_value, default: Money.new(0, "USD"), null: false
      t.bigint :advertiser_id
      t.bigint :publisher_id
      t.bigint :campaign_id
      t.bigint :creative_id
      t.bigint :property_id
      t.string :ip_address
      t.text :user_agent
      t.string :country_code
      t.string :postal_code
      t.decimal :latitude
      t.decimal :longitude
      t.datetime :displayed_at
      t.date :displayed_at_date
      t.datetime :clicked_at
      t.date :clicked_at_date
      t.boolean :fallback_campaign, default: false, null: false
      t.jsonb :metadata, null: false, default: "{}"
      t.text :conversion_referrer
      t.timestamps

      t.index [:pixel_id, :impression_id_param], unique: true
      t.index :pixel_id
      t.index :impression_id
      t.index :advertiser_id
      t.index :campaign_id
      t.index :creative_id
      t.index :property_id
      t.index :country_code
      t.index :displayed_at_date
      t.index :clicked_at_date
      t.index :metadata, using: :gin
    end
  end
end
