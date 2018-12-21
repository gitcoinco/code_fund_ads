# == Schema Information
#
# Table name: organizations
#
#  id               :bigint(8)        not null, primary key
#  name             :string           not null
#  balance_cents    :integer          default(0), not null
#  balance_currency :string           default("USD"), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Organization < ApplicationRecord
  # extends ...................................................................

  # includes ..................................................................
  include Organizations::Developable

  # relationships .............................................................
  has_many :campaigns
  has_many :creatives
  has_many :impressions
  has_many :organization_transactions
  has_many :users

  # validations ...............................................................
  validates :name, presence: true
  validates_each :name do |record, attr, value|
    record.errors.add(attr, "'#{value}' is reserved") if ENUMS::RESERVED_ORGANIZATION_NAMES[value.downcase.strip]
  end

  # callbacks .................................................................

  # scopes ....................................................................
  scope :search_name, ->(value) { value.blank? ? all : search_column(:name, value) }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  monetize :balance_cents, numericality: true

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def total_debits
    Money.new(organization_transactions.debits.sum(&:amount), "USD")
  end

  def total_credits
    Money.new(organization_transactions.credits.sum(&:amount), "USD")
  end

  def recalculate_balance!
    update_attribute(:balance, total_debits - total_credits)
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end
