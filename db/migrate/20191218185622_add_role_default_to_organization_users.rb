class AddRoleDefaultToOrganizationUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:organization_users, :role, from: nil, to: "member")
  end
end
