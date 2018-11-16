class AddDefaultPartitionForImpressions < ActiveRecord::Migration[5.2]
  def up
    execute "CREATE TABLE impressions_default PARTITION OF impressions DEFAULT;"
    add_index :impressions_default, :displayed_at_date
    add_index :impressions_default, "date_trunc('hour', displayed_at)", name: "index_impressions_default_on_displayed_at_hour"
    add_index :impressions_default, :campaign_id
    add_index :impressions_default, :property_id
    add_index :impressions_default, :payable
  end

  def down
    execute "DROP TABLE impressions_default;"
  end
end
