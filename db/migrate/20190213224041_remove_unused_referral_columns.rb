class RemoveUnusedReferralColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :applicants, :referring_campaign_id
    remove_column :applicants, :referring_impression_id
    remove_column :applicants, :referring_property_id

    remove_column :users, :referring_campaign_id
    remove_column :users, :referring_impression_id
    remove_column :users, :referring_property_id
  end
end
