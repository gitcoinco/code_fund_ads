# == Schema Information
#
# Table name: organization_transactions
#
#  id               :bigint(8)        not null, primary key
#  organization_id  :bigint(8)        not null
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
  after_commit :update_organization_balance, on: [:create, :update, :destroy]

  # scopes ....................................................................
  scope :debits, -> { where(transaction_type: ENUMS::ORGANIZATION_TRANSACTION_TYPES::DEBIT) }
  scope :credits, -> { where(transaction_type: ENUMS::ORGANIZATION_TRANSACTION_TYPES::CREDIT) }
  scope :gift, -> { where(gift: true) }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  monetize :amount_cents, numericality: true

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  # protected instance methods ................................................

  # private instance methods ..................................................
  private

  def update_organization_balance
    organization.recalculate_balance!
  end
end
