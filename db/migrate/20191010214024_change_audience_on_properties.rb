class ChangeAudienceOnProperties < ActiveRecord::Migration[6.0]
  def up
    remove_column :properties, :audience
    add_column :properties, :audience_id, :bigint
    add_index :properties, :audience_id
  end

  def down
    remove_column :properties, :audience_id
    add_column :properties, :audience, :string
    add_index :properties, :audience
  end
end
