class IndexReferenceOnOrganizationTransactions < ActiveRecord::Migration[5.2]
  def change
    add_index :organization_transactions, :reference
  end
end
