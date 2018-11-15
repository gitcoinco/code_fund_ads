# frozen_string_literal: true

class AddExtraFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :us_resident, :boolean, default: false
    add_column :users, :bio, :text
    add_column :users, :website_url, :string
    add_column :users, :skills, :text, default: [], array: true
    add_column :users, :github_username, :string
    add_column :users, :twitter_username, :string
    add_column :users, :linkedin_username, :string
  end
end
