class AddUrlToOrganizations < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :url, :text
  end
end
