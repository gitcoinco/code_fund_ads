class DropCommentsTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :comments
  end

  def down
    create_table :comments, force: true do |t|
      t.bigint :commentable_id
      t.string :commentable_type
      t.string :title
      t.text :body
      t.string :subject
      t.bigint :user_id, null: false
      t.bigint :parent_id, :lft, :rgt
      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
