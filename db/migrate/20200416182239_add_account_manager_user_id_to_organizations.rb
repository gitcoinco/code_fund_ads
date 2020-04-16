class AddAccountManagerUserIdToOrganizations < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :account_manager_user_id, :bigint
    add_index :organizations, :account_manager_user_id
  end
end
