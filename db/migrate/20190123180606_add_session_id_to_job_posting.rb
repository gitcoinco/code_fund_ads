class AddSessionIdToJobPosting < ActiveRecord::Migration[5.2]
  def change
    add_column :job_postings, :session_id, :string
    add_index :job_postings, :session_id
  end
end
