class AddViewTrackingToJobPosting < ActiveRecord::Migration[5.2]
  def change
    add_column :job_postings, :list_view_count, :integer, null: false, default: 0
    add_column :job_postings, :detail_view_count, :integer, null: false, default: 0
    add_index :job_postings, :list_view_count
    add_index :job_postings, :detail_view_count
  end
end
