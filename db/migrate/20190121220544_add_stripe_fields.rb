class AddStripeFields < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :stripe_customer_id, :string
    add_column :job_postings, :stripe_charge_id, :string
  end
end
