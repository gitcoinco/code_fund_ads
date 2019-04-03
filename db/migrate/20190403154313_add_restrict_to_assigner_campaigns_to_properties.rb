class AddRestrictToAssignerCampaignsToProperties < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :restrict_to_assigner_campaigns, :boolean, default: false, null: false
  end
end
