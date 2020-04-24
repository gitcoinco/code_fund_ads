class AddUserIdsToInboundEmails < ActiveRecord::Migration[6.0]
  def change
    add_column :action_mailbox_inbound_emails, :delivered_at, :datetime
    add_column :action_mailbox_inbound_emails, :sender_id, :bigint, default: 0, null: false
    add_column :action_mailbox_inbound_emails, :to_ids, :text, array: true, default: []
    add_column :action_mailbox_inbound_emails, :cc_ids, :text, array: true, default: []
    add_index :action_mailbox_inbound_emails, :sender_id
    add_index :action_mailbox_inbound_emails, :to_ids, using: :gin
    add_index :action_mailbox_inbound_emails, :cc_ids, using: :gin
  end
end
