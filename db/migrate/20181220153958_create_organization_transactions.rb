class CreateOrganizationTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :organization_transactions do |t|
      t.bigint :organization_id, null: false
      t.monetize :amount, null: false, default: 0.0
      t.string :transaction_type, null: false
      t.datetime :posted_at, null: false
      t.text :description
      t.text :reference

      t.index :organization_id
      t.index :transaction_type

      t.timestamps
    end
  end
end
