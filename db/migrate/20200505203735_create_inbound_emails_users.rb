class CreateInboundEmailsUsers < ActiveRecord::Migration[6.0]
  def change
    create_join_table :inbound_emails, :users do |t|
      t.index :inbound_email_id
      t.index :user_id
    end
  end
end
