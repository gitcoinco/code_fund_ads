class AddPlansAndOffersToJobPosting < ActiveRecord::Migration[5.2]
  def change
    add_column :job_postings, :plan, :string
    add_column :job_postings, :offers, :string, array: true, default: [], null: false
    add_index :job_postings, :plan
    add_index :job_postings, :offers, using: :gin
  end
end
