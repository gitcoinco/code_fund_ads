class AddCompanyEmailToJobPostings < ActiveRecord::Migration[5.2]
  def change
    add_column :job_postings, :company_email, :string
  end
end
