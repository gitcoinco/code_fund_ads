# == Schema Information
#
# Table name: organization_transactions
#
#  id               :bigint(8)        not null, primary key
#  organization_id  :integer          not null
#  amount_cents     :integer          default(0), not null
#  amount_currency  :string           default("USD"), not null
#  transaction_type :string           not null
#  posted_at        :datetime         not null
#  description      :text
#  reference        :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class OrganizationTransaction < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :organization

  # validations ...............................................................
  validates :posted_at, presence: true
  validates :transaction_type, presence: true, inclusion: {in: ENUMS::ORGANIZATION_TRANSACTION_TYPES.values}

  # callbacks .................................................................
  # scopes ....................................................................
  
  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  monetize :amount_cents, numericality: true

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  # protected instance methods ................................................
  protected

  # private instance methods ..................................................
  private
end
