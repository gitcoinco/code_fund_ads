class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.monetize :balance, null: false, default: 0.0

      t.timestamps
    end
  end
end
