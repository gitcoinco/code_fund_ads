class ReferralCleanup < ActiveRecord::Migration[5.2]
  def change
    remove_column :applicants, :hubspot_deal_vid, :bigint
    remove_column :applicants, :hubspot_contact_vid, :bigint
    remove_column :applicants, :hubspot_company_vid, :bigint
    remove_column :users, :hubspot_deal_vid, :bigint
    remove_column :users, :hubspot_contact_vid, :bigint
    remove_column :users, :hubspot_company_vid, :bigint

    drop_table :applicants
    drop_table :email_templates
  end
end
