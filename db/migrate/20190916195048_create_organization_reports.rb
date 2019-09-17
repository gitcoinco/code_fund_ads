class CreateOrganizationReports < ActiveRecord::Migration[5.2]
  def change
    create_table :organization_reports do |t|
      t.bigint :organization_id, null: false
      t.string :title, null: false
      t.string :status, default: "pending", null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.text :campaign_ids, array: true, default: []
      t.text :pdf_url

      t.index :organization_id

      t.timestamps
    end
  end
end
