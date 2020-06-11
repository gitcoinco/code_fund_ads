# == Schema Information
#
# Table name: organizations
#
#  id                       :bigint           not null, primary key
#  balance_cents            :integer          default(0), not null
#  balance_currency         :string           default("USD"), not null
#  creative_approval_needed :boolean          default(TRUE)
#  name                     :string           not null
#  url                      :text
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  account_manager_user_id  :bigint
#
# Indexes
#
#  index_organizations_on_account_manager_user_id   (account_manager_user_id)
#  index_organizations_on_creative_approval_needed  (creative_approval_needed)
#

require "csv"

class Organization < ApplicationRecord
  # extends ...................................................................

  # includes ..................................................................
  include Organizations::Statusable
  include Organizations::Developable
  include Organizations::Imageable
  include Organizations::Advertiseable
  include Eventable
  include Imageable

  # relationships .............................................................
  belongs_to :account_manager, class_name: "User", foreign_key: "account_manager_user_id", optional: true
  has_many :campaigns
  has_many :campaign_bundles
  has_many :creatives
  has_many :creative_images, through: :creatives
  has_many :impressions
  has_many :job_postings
  has_many :organization_reports
  has_many :organization_transactions
  has_many :organization_users, dependent: :destroy
  has_many :pixels, dependent: :destroy
  has_many :pixel_conversions
  has_many :scheduled_organization_reports
  has_many :users, through: :organization_users
  has_many :administrators, -> { where organization_users: {role: ENUMS::ORGANIZATION_ROLES::ADMINISTRATOR} }, through: :organization_users, source: "user"
  has_many :members, -> { where organization_users: {role: ENUMS::ORGANIZATION_ROLES::MEMBER} }, through: :organization_users, source: "user"

  # validations ...............................................................
  validates :url, url: true, presence: false
  validates :name, presence: true
  validates_each :name, unless: :skip_validation do |record, attr, value|
    if record.name_changed? && ENUMS::RESERVED_ORGANIZATION_NAMES[value.downcase.strip]
      record.errors.add(attr, "'#{value}' is reserved")
    end
  end
  validate :administrator_exists_validator, if: proc { |record| record.organization_users.exists? }

  # callbacks .................................................................

  # scopes ....................................................................
  scope :with_positive_balance, -> { where(Organization.arel_table[:balance_cents].gt(0)) }
  scope :with_negative_balance, -> { where(Organization.arel_table[:balance_cents].lt(0)) }
  scope :with_zero_balance, -> { where(balance_cents: 0) }
  scope :search_name, ->(value) { value.blank? ? all : search_column(:name, value) }
  scope :search_balance_direction, ->(value) {
    case value
      when ENUMS::ORGANIZATION_SEARCH_DIRECTIONS::POSITIVE then with_positive_balance
      when ENUMS::ORGANIZATION_SEARCH_DIRECTIONS::NEGATIVE then with_negative_balance
      when ENUMS::ORGANIZATION_SEARCH_DIRECTIONS::ZERO then with_zero_balance
      else all
    end
  }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  attr_accessor :skip_validation
  monetize :balance_cents, numericality: true
  acts_as_commentable
  has_paper_trail on: %i[update destroy], only: %i[
    name
  ]

  # class methods .............................................................
  class << self
    def codefund
      where(name: "CodeFund").first_or_create!(skip_validation: true)
    end
    alias positive with_positive_balance
    alias negative with_negative_balance
    alias zero with_zero_balance
  end

  # public instance methods ...................................................

  def total_debits
    Money.new(organization_transactions.debits.sum(&:amount_cents), "USD")
  end

  def total_credits
    Money.new(organization_transactions.credits.sum(&:amount_cents), "USD")
  end

  def total_gifts
    Money.new(organization_transactions.credited_gifts.sum(&:amount_cents), "USD")
  end

  def recalculate_balance!
    update_attribute(:balance, total_credits - total_debits)
  end

  def organization_transactions_csv
    CSV.generate do |csv|
      csv << %w[
        id
        organization_id
        posted_at
        amount
        transaction_type
        gift
        description
        reference
      ]
      organization_transactions.each do |record|
        row = []
        row << record.id
        row << record.organization_id
        row << record.posted_at
        row << record.amount.format
        row << record.transaction_type
        row << record.gift
        row << record.description
        row << record.reference
        csv << row
      end
    end
  end

  # protected instance methods ................................................
  # private instance methods ..................................................

  private

  def administrator_exists_validator
    errors.add :base, "You need at least one administrator in the organization." if administrators.empty?
  end
end
