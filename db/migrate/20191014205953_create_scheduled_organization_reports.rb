class CreateScheduledOrganizationReports < ActiveRecord::Migration[6.0]
  def change
    create_table :scheduled_organization_reports do |t|
      t.bigint :organization_id, null: false
      t.text :subject, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :frequency, null: false
      t.string :dataset, null: false
      t.bigint :campaign_ids, array: true, default: [], null: false
      t.string :recipients, array: true, default: [], null: false

      t.index :organization_id

      t.timestamps
    end
  end
end
