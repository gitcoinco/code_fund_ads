class AddImpressionsEstimatedRevenue < ActiveRecord::Migration[5.2]
  def change
    # NOTE: nulls are permitted intentionally
    add_column :impressions, :estimated_gross_revenue_fractional_cents, :float
    add_column :impressions, :estimated_property_revenue_fractional_cents, :float
    add_column :impressions, :estimated_house_revenue_fractional_cents, :float
  end
end
