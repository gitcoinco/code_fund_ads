class AddSubdivisionTargeting < ActiveRecord::Migration[5.2]
  def change
    add_column :impressions, :province_code, :string
    add_index :impressions, :province_code

    rename_column :campaigns, :countries, :country_codes
    add_column :campaigns, :province_codes, :string, default: [], array: true
    add_index :campaigns, :province_codes, using: :gin
  end
end
