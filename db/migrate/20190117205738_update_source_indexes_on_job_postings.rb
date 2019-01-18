class UpdateSourceIndexesOnJobPostings < ActiveRecord::Migration[5.2]
  def change
    remove_index :job_postings, :source
    remove_index :job_postings, :source_identifier
    add_index :job_postings, [:source, :source_identifier], unique: true
  end
end
