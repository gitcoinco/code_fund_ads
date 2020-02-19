# == Schema Information
#
# Table name: organization_transactions
#
#  id               :bigint           not null, primary key
#  amount_cents     :integer          default(0), not null
#  amount_currency  :string           default("USD"), not null
#  description      :text
#  gift             :boolean          default(FALSE)
#  posted_at        :datetime         not null
#  reference        :text
#  transaction_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  organization_id  :bigint           not null
#
# Indexes
#
#  index_organization_transactions_on_gift              (gift)
#  index_organization_transactions_on_organization_id   (organization_id)
#  index_organization_transactions_on_reference         (reference)
#  index_organization_transactions_on_transaction_type  (transaction_type)
#

require "test_helper"

class OrganizationTransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
