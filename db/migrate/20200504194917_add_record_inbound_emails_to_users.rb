class AddRecordInboundEmailsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :record_inbound_emails, :boolean, default: false
  end
end
