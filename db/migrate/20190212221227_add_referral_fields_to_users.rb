class AddReferralFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :referral_code, :string
    add_column :users, :referral_click_count, :integer, default: 0
    add_column :applicants, :referring_user_id, :bigint

    add_index :users, :referral_code, unique: true
  end
end
