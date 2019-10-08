class SetCorrectDatatypeOnOrganizationReportsCampaignIds < ActiveRecord::Migration[6.0]
  def up
    add_column :organization_reports, :campaign_ids_temp, :bigint, array: true, default: [], null: false
    OrganizationReport.all.each do |report|
      report.update_columns campaign_ids_temp: report.campaign_ids.map(&:to_i)
    end
    remove_column :organization_reports, :campaign_ids
    rename_column :organization_reports, :campaign_ids_temp, :campaign_ids
  end

  def down
    add_column :organization_reports, :campaign_ids_temp, :text, array: true, default: [], null: false
    OrganizationReport.all.each do |report|
      report.update_columns campaign_ids_temp: report.campaign_ids.map(&:to_s)
    end
    remove_column :organization_reports, :campaign_ids
    rename_column :organization_reports, :campaign_ids_temp, :campaign_ids
  end
end
