class AddImpressionIndexes < ActiveRecord::Migration[5.2]
  def up
    rename_column :impressions, :country, :country_code
    add_index :impressions, :country_code, name: "index_impressions_on_country_code"
    add_index :impressions, [:campaign_name, :property_name], name: "index_impressions_on_campaign_name_and_property_name"
  end

  def down
    # NOTE: remove_index doesn't work since impressions is a partitioned table
    execute "DROP INDEX \"index_impressions_on_country\";"
    execute "DROP INDEX \"index_impressions_on_campaign_name_and_property_name\";"
    rename_column :impressions, :country_code, :country
  end
end
