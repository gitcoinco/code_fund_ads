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
  # relationships .............................................................
  has_many :users

  # validations ...............................................................
  validates :name, presence: true
  validates_each :name do |record, attr, value|
    record.errors.add(attr, "'#{value}' is reserved") if ENUMS::RESERVED_ORGANIZATION_NAMES.values.include? value.downcase.strip
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

  # protected instance methods ................................................
  protected

  # private instance methods ..................................................
  private
end
