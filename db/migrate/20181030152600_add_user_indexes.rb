# frozen_string_literal: true

class AddUserIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :users, "(lower(first_name))", name: "index_users_on_first_name"
    add_index :users, "(lower(last_name))", name: "index_users_on_last_name"
    add_index :users, "(lower(email))", name: "index_users_on_email"
    add_index :users, "(lower(company))", name: "index_users_on_company"
    add_index :users, :roles, using: :gin

    reversible do |direction|
      direction.up do
        remove_index :users, name: "users_email_index"
      end
      direction.down do
        add_index :users, :email, name: "users_email_index"
      end
    end
  end
end
