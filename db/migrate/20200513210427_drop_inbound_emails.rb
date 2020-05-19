class DropInboundEmails < ActiveRecord::Migration[6.0]
  def up
    drop_join_table :inbound_emails, :users
    drop_table :inbound_emails
  end

  def down
    create_table :inbound_emails do |t|
      t.bigint :action_mailbox_inbound_email_id, null: false
      t.string :sender, null: false
      t.text :recipients, array: true, default: [], null: false
      t.text :subject
      t.text :snippet
      t.text :body
      t.datetime :delivered_at, null: false

      t.timestamps
    end

    create_join_table :inbound_emails, :users do |t|
      t.index :inbound_email_id
      t.index :user_id
    end
  end
end
