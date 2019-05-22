class AddStatusToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :status, :string, default: ENUMS::USER_STATUSES::ACTIVE
  end
end
