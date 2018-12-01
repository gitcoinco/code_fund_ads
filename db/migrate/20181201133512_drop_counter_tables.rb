class DropCounterTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :impression_counters
    drop_table :click_counters
  end
end
