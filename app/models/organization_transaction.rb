# == Schema Information
#
# Table name: organization_transactions
#
#  id               :bigint           not null, primary key
#  organization_id  :bigint           not null
#  amount_cents     :integer          default(0), not null
#  amount_currency  :string           default("USD"), not null
#  transaction_type :string           not null
#  posted_at        :datetime         not null
#  description      :text
#  reference        :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  gift             :boolean          default(FALSE)
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
