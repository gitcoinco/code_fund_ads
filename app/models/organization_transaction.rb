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

class OrganizationTransaction < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :organization

  # validations ...............................................................
  validates :posted_at, presence: true
  validates :transaction_type, presence: true, inclusion: {in: ENUMS::ORGANIZATION_TRANSACTION_TYPES.values}
  validates :description, presence: true

  # callbacks .................................................................

  # scopes ....................................................................
  scope :debits, -> { where(transaction_type: ENUMS::ORGANIZATION_TRANSACTION_TYPES::DEBIT) }
  scope :credits, -> { where(transaction_type: ENUMS::ORGANIZATION_TRANSACTION_TYPES::CREDIT) }
  scope :gift, -> { where(gift: true) }
  scope :posted_between, ->(start_date, end_date = nil) {
    start_date, end_date = range_boundary(start_date) if start_date.is_a?(Range)
    where posted_at: Date.coerce(start_date)..Date.coerce(end_date)
  }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  monetize :amount_cents, numericality: true

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  # protected instance methods ................................................

  # private instance methods ..................................................
end
