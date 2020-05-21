class AddEmailThreadingToEmails < ActiveRecord::Migration[6.0]
  def change
    add_column :emails, :in_reply_to, :string
    add_column :emails, :message_id, :string
    add_column :emails, :parent_id, :bigint
    add_index :emails, :parent_id
  end
end
