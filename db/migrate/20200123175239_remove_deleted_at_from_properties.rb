class RemoveDeletedAtFromProperties < ActiveRecord::Migration[6.0]
  def change
    remove_column :properties, :deleted_at, :datetime
  end
end
