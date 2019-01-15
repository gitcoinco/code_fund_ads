class CreateJobPostings < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :job_posting, :boolean, null: false, default: false
    add_index :campaigns, :job_posting

    create_table :job_postings do |t|
      t.bigint :organization_id, null: false
      t.bigint :user_id, null: false
      t.bigint :campaign_id
      t.string :source, null: false, default: ENUMS::JOB_SOURCES::INTERNAL
      t.string :source_identifier
      t.string :job_type, null: false
      t.string :company_name
      t.string :company_logo_url
      t.string :title, null: false
      t.text :description, null: false
      t.string :keywords, array: true, default: [], null: false
      t.monetize :min_annual_salary, null: false, default: Money.new(75_000, "USD")
      t.monetize :max_annual_salary
      t.boolean :remote, null: false, default: false
      t.string :city
      t.string :province_name
      t.string :province_code
      t.string :country_code
      t.text :url
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.tsvector :full_text_search
      t.timestamps

      t.index :organization_id
      t.index :user_id
      t.index :campaign_id
      t.index :source
      t.index :source_identifier
      t.index :job_type
      t.index :company_name
      t.index :title
      t.index :keywords, using: :gin
      t.index :min_annual_salary_cents
      t.index :max_annual_salary_cents
      t.index :remote
      t.index :city
      t.index :province_name
      t.index :province_code
      t.index :country_code
      t.index :start_date
      t.index :end_date
      t.index :full_text_search, using: :gin
    end
  end
end
