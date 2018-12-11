class ChangeCommentableToBigint < ActiveRecord::Migration[5.2]
  def up
    change_column :comments, :commentable_id, :bigint, null: false
    change_column :comments, :commentable_type, :string, null: false
  end

  def down
    change_column :comments, :commentable_id, :int, null: true
    change_column :comments, :commentable_type, :string, null: true
  end
end
