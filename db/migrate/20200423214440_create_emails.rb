class CreateEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :emails do |t|
      t.string :message_id, null: false
      t.string :from_address, null: false
      t.text :to_addresses, array: true, default: []
      t.text :cc_addresses, array: true, default: []
      t.string :subject, null: false
      t.text :content, null: false
      t.datetime :delivered_at, null: false

      t.index :message_id, unique: true
      t.index :from_address
      t.index :to_addresses, using: :gin
      t.index :cc_addresses, using: :gin

      t.timestamps
    end
  end
end
