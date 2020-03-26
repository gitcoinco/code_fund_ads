class AddTemporaryToOrganizationTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :organization_transactions, :temporary, :boolean, default: false
  end
end
