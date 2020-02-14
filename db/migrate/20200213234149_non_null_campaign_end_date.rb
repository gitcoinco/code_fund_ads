class NonNullCampaignEndDate < ActiveRecord::Migration[6.0]
  def up
    change_column :campaigns, :start_date, :date, null: false
    change_column :campaigns, :end_date, :date, null: false
    change_column :campaign_bundles, :start_date, :date, null: false
    change_column :campaign_bundles, :end_date, :date, null: false
  end

  def down
    change_column :campaigns, :start_date, :date, null: true
    change_column :campaigns, :end_date, :date, null: true
    change_column :campaign_bundles, :start_date, :date, null: true
    change_column :campaign_bundles, :end_date, :date, null: true
  end
end
