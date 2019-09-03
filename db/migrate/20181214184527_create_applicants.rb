class CreateApplicants < ActiveRecord::Migration[5.2]
  def change
    create_table :applicants do |t|
      t.string :status, default: "pending"
      t.string :role, null: false
      t.string :email, null: false
      t.string :canonical_email, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :url, null: false
      t.string :monthly_visitors
      t.string :company_name
      t.string :monthly_budget

      t.timestamps
    end
  end
end
