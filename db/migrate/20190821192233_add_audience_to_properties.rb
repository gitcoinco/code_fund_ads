class AddAudienceToProperties < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :audience, :string
    add_index :properties, :audience
  end
end
