class DisallowNullRemoteCountryCodes < ActiveRecord::Migration[5.2]
  def change
    change_column :job_postings, :remote_country_codes, :string, array: true, default: [], null: false
    add_index :job_postings, :remote_country_codes, using: :gin
  end
end
