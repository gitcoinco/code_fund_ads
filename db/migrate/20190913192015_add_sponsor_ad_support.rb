class AddSponsorAdSupport < ActiveRecord::Migration[5.2]
  def up
    change_column :creatives, :headline, :string, null: true
    add_column :creatives, :creative_type, :string, null: false, default: "standard"
    add_column :campaigns, :clicks, :integer, null: false, default: 0
    add_index :creatives, :creative_type
    add_index :impressions, :ip_address, name: "index_impressions_on_ip_address"
  end

  def down
    change_column :creatives, :headline, :string, null: false
    remove_column :creatives, :creative_type
    remove_column :campaigns, :clicks
    execute "DROP INDEX IF EXISTS index_impressions_on_ip_address;"
    Impression.attached_table_names.each do |table_name|
      execute "DROP INDEX IF EXISTS #{table_name}_ip_address_idx;"
    end
  end
end
