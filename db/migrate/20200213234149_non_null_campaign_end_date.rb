class NonNullCampaignEndDate < ActiveRecord::Migration[6.0]
  def up
    change_column :campaigns, :start_date, :datetime, null: false
    change_column :campaigns, :end_date, :datetime, null: false
    change_column :campaign_bundles, :start_date, :datetime, null: false
    change_column :campaign_bundles, :end_date, :datetime, null: false
  end

  def down
    change_column :campaigns, :start_date, :datetime, null: true
    change_column :campaigns, :end_date, :datetime, null: true
    change_column :campaign_bundles, :start_date, :datetime, null: true
    change_column :campaign_bundles, :end_date, :datetime, null: true
  end
end
