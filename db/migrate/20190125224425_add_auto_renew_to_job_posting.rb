class AddAutoRenewToJobPosting < ActiveRecord::Migration[5.2]
  def change
    add_column :job_postings, :auto_renew, :boolean, null: false, default: true
    add_index :job_postings, :auto_renew
  end
end
