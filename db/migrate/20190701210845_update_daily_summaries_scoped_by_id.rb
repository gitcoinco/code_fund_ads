class UpdateDailySummariesScopedById < ActiveRecord::Migration[5.2]
  def change
    change_column :daily_summaries, :scoped_by_id, :string
  end
end
