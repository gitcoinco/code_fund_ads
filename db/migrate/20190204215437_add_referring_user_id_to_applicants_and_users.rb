class AddReferringUserIdToApplicantsAndUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :applicants, :referring_campaign_id, :bigint
    add_column :applicants, :referring_property_id, :bigint
    add_column :applicants, :referring_impression_id, :uuid
    add_column :users, :referring_user_id, :bigint
    add_column :users, :referring_campaign_id, :bigint
    add_column :users, :referring_property_id, :bigint
    add_column :users, :referring_impression_id, :uuid
    add_index :users, :referring_user_id
  end
end
