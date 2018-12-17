class RenameCampaignUsHoursOnly < ActiveRecord::Migration[5.2]
  def change
    rename_column :campaigns, :us_hours_only, :core_hours_only
  end
end
