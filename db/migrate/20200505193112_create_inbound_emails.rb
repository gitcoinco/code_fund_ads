class CreateInboundEmails < ActiveRecord::Migration[6.0]
  def change
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
  end
end
