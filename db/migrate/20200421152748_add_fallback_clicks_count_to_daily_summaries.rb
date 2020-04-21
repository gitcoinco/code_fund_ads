class AddFallbackClicksCountToDailySummaries < ActiveRecord::Migration[6.0]
  def change
    add_column :daily_summaries, :fallback_clicks_count, :bigint, default: 0, null: false
  end
end
