class AddCreativeApprovalNeededToOrganizations < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :creative_approval_needed, :boolean, default: true
    add_index :organizations, :creative_approval_needed
  end
end
