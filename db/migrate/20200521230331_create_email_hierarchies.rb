class CreateEmailHierarchies < ActiveRecord::Migration[6.0]
  def change
    create_table :email_hierarchies, id: false do |t|
      t.bigint :ancestor_id, null: false
      t.bigint :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :email_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "email_anc_desc_idx"

    add_index :email_hierarchies, [:descendant_id],
      name: "email_desc_idx"
  end
end
