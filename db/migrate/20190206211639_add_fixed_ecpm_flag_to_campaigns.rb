class AddFixedEcpmFlagToCampaigns < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :fixed_ecpm, :boolean, default: true, null: false
  end
end
