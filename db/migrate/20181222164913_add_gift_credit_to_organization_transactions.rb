class AddGiftCreditToOrganizationTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :organization_transactions, :gift, :boolean, default: false
    add_index :organization_transactions, :gift
  end
end
