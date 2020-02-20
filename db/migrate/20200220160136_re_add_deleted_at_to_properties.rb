class ReAddDeletedAtToProperties < ActiveRecord::Migration[6.0]
  def change
    add_column :properties, :deleted_at, :datetime
  end
end
