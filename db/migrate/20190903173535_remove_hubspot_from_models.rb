class RemoveHubspotFromModels < ActiveRecord::Migration[5.2]
  def change
    remove_column :applicants, :hubspot_deal_vid
    remove_column :applicants, :hubspot_contact_vid
    remove_column :applicants, :hubspot_company_vid
    remove_column :users, :hubspot_deal_vid
    remove_column :users, :hubspot_contact_vid
    remove_column :users, :hubspot_company_vid
  end
end
