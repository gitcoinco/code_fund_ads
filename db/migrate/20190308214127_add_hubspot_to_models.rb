class AddHubspotToModels < ActiveRecord::Migration[5.2]
  def change
    add_column :applicants, :hubspot_deal_vid, :bigint
    add_column :applicants, :hubspot_contact_vid, :bigint
    add_column :applicants, :hubspot_company_vid, :bigint
    add_column :users, :hubspot_deal_vid, :bigint
    add_column :users, :hubspot_contact_vid, :bigint
    add_column :users, :hubspot_company_vid, :bigint
  end
end
