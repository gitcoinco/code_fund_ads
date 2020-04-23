class CreateEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :emails do |t|
      t.string :message_id, null: false
      t.string :from, null: false
      t.string :to, null: false
      t.string :subject, null: false
      t.text :content, null: false
      t.datetime :delivered_at, null: false

      t.index :message_id, unique: true

      t.timestamps
    end
  end
end
