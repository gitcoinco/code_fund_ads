class SetBigIntFksOnCommentsAndEvents < ActiveRecord::Migration[5.2]
  def change
    change_column :comments, :user_id, :bigint
    change_column :comments, :parent_id, :bigint
    change_column :events, :eventable_id, :bigint
    change_column :events, :user_id, :bigint
  end
end
