class CreateEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :emails do |t|
      t.text :body
      t.datetime :delivered_at, default: "now()", null: false
      t.date :delivered_at_date, default: "now()::date", null: false
      t.string :recipients, array: true, default: [], null: false
      t.string :sender
      t.text :snippet
      t.text :subject
      t.bigint :action_mailbox_inbound_email_id, null: false
      t.string :direction, null: false, default: "inbound"

      t.index :sender
      t.index :recipients, using: :gin
      t.index :delivered_at_date
      t.index "date_trunc('hour', delivered_at)", name: "index_emails_on_delivered_at_hour"

      t.timestamps
    end
  end
end
