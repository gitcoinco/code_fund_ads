class RecreateDailySummaryIndexes < ActiveRecord::Migration[5.2]
  def change
    remove_index :daily_summaries, name: "index_daily_summaries_unscoped_uniqueness"
    remove_index :daily_summaries, name: "index_daily_summaries_uniqueness"
    remove_index :daily_summaries, name: "index_daily_summaries_on_impressionable_columns"
    remove_index :daily_summaries, name: "index_daily_summaries_on_scoped_by_columns"

    add_index :daily_summaries, [:impressionable_type, :impressionable_id, :displayed_at_date], name: "index_daily_summaries_unscoped_uniqueness", unique: true, where: "((scoped_by_type IS NULL) AND (scoped_by_id IS NULL))"
    add_index :daily_summaries, [:impressionable_type, :impressionable_id, :scoped_by_type, :scoped_by_id, :displayed_at_date], name: "index_daily_summaries_uniqueness", unique: true
    add_index :daily_summaries, [:impressionable_type, :impressionable_id], name: "index_daily_summaries_on_impressionable_columns"
    add_index :daily_summaries, [:scoped_by_type, :scoped_by_id], name: "index_daily_summaries_on_scoped_by_columns"
  end
end
