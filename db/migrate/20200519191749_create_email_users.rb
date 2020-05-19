class CreateEmailUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :email_users do |t|
      t.bigint :email_id, null: false
      t.bigint :user_id, null: false
      t.index [:email_id, :user_id], unique: true
    end
  end
end
