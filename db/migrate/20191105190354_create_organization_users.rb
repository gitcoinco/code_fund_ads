class CreateOrganizationUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :organization_users do |t|
      t.belongs_to :organization, null: false
      t.belongs_to :user, null: false
      t.string :role, null: false

      t.timestamps
      t.index [:organization_id, :user_id, :role], unique: true, name: "index_organization_users_on_uniqueness"
    end
  end
end
