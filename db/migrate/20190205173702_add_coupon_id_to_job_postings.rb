class AddCouponIdToJobPostings < ActiveRecord::Migration[5.2]
  def change
    add_column :job_postings, :coupon_id, :bigint
    add_index :job_postings, :coupon_id
  end
end
