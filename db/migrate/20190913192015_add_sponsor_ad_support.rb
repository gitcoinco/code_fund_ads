class AddSponsorAdSupport < ActiveRecord::Migration[5.2]
  def up
    change_column :creatives, :headline, :string, null: true
    add_column :creatives, :creative_type, :string, null: false, default: "standard"
    add_index :creatives, :creative_type
  end

  def down
    change_column :creatives, :headline, :string, null: false
    remove_column :creatives, :creative_type
  end
end
