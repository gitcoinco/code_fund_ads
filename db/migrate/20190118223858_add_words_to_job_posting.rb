class AddWordsToJobPosting < ActiveRecord::Migration[5.2]
  def change
    enable_extension :pg_trgm

    create_table :words do |t|
      t.string :record_type, null: false
      t.bigint :record_id, null: false
      t.text :word, null: false

      t.index [:record_type, :record_id]
      t.index [:record_type, :record_id, :word], unique: true
      t.index :word, using: :gin, opclass: "gin_trgm_ops"
    end
  end
end
