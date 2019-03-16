class AddUpliftToImpressions < ActiveRecord::Migration[5.2]
  def change
    add_column :impressions, :uplift, :boolean, default: false
    add_index :impressions, :uplift
  end
end
