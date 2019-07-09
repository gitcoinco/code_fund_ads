class PartitionDailySummaries < ActiveRecord::Migration[5.2]
  def change
    rename_table "daily_summaries", "daily_summaries_old"

    create_table :daily_summaries, id: false, options: "PARTITION BY HASH (impressionable_type, impressionable_id, scoped_by_type, scoped_by_id, displayed_at_date)" do |t|
      t.string :impressionable_type, null: false
      t.bigint :impressionable_id, null: false
      t.string :scoped_by_type
      t.string :scoped_by_id
      t.integer :impressions_count, default: 0, null: false
      t.integer :fallbacks_count, default: 0, null: false
      t.decimal :fallback_percentage, default: "0.0", null: false
      t.integer :clicks_count, default: 0, null: false
      t.decimal :click_rate, default: "0.0", null: false
      t.integer :ecpm_cents, default: 0, null: false
      t.string :ecpm_currency, default: "USD", null: false
      t.integer :cost_per_click_cents, default: 0, null: false
      t.string :cost_per_click_currency, default: "USD", null: false
      t.integer :gross_revenue_cents, default: 0, null: false
      t.string :gross_revenue_currency, default: "USD", null: false
      t.integer :property_revenue_cents, default: 0, null: false
      t.string :property_revenue_currency, default: "USD", null: false
      t.integer :house_revenue_cents, default: 0, null: false
      t.string :house_revenue_currency, default: "USD", null: false
      t.date :displayed_at_date, null: false
      t.timestamps

      t.index :displayed_at_date, name: "index_pdaily_summaries_on_displayed_at_date"
      t.index [:impressionable_type, :impressionable_id, :scoped_by_type, :scoped_by_id, :displayed_at_date], name: "index_pdaily_summaries_uniqueness", unique: true
      t.index [:impressionable_type, :impressionable_id], name: "index_pdaily_summaries_on_impressionable_columns"
      t.index [:scoped_by_type, :scoped_by_id], name: "index_pdaily_summaries_on_scoped_by_columns"
    end

    10.times do |i|
      execute "CREATE TABLE daily_summaries_p#{i} PARTITION OF daily_summaries FOR VALUES WITH (MODULUS 10, REMAINDER #{i});"
    end

    execute <<~SQL
      INSERT INTO daily_summaries
      SELECT
      impressionable_type,
      impressionable_id,
      scoped_by_type,
      scoped_by_id,
      impressions_count,
      fallbacks_count,
      fallback_percentage,
      clicks_count,
      click_rate,
      ecpm_cents,
      ecpm_currency,
      cost_per_click_cents,
      cost_per_click_currency,
      gross_revenue_cents,
      gross_revenue_currency,
      property_revenue_cents,
      property_revenue_currency,
      house_revenue_cents,
      house_revenue_currency,
      displayed_at_date,
      created_at,
      updated_at
      FROM daily_summaries_old;
    SQL
  end
end
