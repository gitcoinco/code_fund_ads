class AddGiftCreditToOrganizationTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :organization_transactions, :gift_credit, :boolean, default: false
    add_index :organization_transactions, :gift_credit
  end
end
