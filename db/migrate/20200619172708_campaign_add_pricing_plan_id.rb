class CampaignAddPricingPlanId < ActiveRecord::Migration[6.0]
  def change
    add_column :campaign_bundles, :pricing_plan_id, :bigint
    add_column :campaigns, :pricing_plan_id, :bigint

    add_index :campaign_bundles, :pricing_plan_id
    add_index :campaigns, :pricing_plan_id
  end
end
