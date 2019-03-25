class AddUniqueIndexForNullsToDailySummaries < ActiveRecord::Migration[5.2]
  def change
    execute "truncate daily_summaries"
    add_index :daily_summaries, [:impressionable_type, :impressionable_id, :displayed_at_date],
      unique: true, where: "scoped_by_type IS NULL AND scoped_by_id IS NULL",
      name: "index_daily_summaries_unscoped_uniqueness"
  end
end
