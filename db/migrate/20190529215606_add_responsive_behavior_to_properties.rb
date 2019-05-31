class AddResponsiveBehaviorToProperties < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :responsive_behavior, :string, null: false, default: "none"
  end
end
