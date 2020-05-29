class AddReadAtToEmailUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :email_users, :read_at, :datetime
  end
end
