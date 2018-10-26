# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  email                  :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  address_1              :string(255)
#  address_2              :string(255)
#  city                   :string(255)
#  region                 :string(255)
#  postal_code            :string(255)
#  country                :string(255)
#  roles                  :string(255)      is an Array
#  revenue_rate           :decimal(3, 3)    default(0.5), not null
#  password_hash          :string(255)
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  failed_attempts        :integer          default(0)
#  locked_at              :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  unlock_token           :string(255)
#  remember_created_at    :datetime
#  inserted_at            :datetime         not null
#  updated_at             :datetime         not null
#  paypal_email           :string(255)
#  company                :string(255)
#  api_access             :boolean          default(FALSE), not null
#  api_key                :string(255)
#

class User < ApplicationRecord
  # extends ...................................................................

  # includes ..................................................................
  include TagColumns

  # relationships .............................................................
  has_many :assets
  has_many :campaigns
  has_many :creatives
  has_many :properties

  # validations ...............................................................
  validates :address_1, length: { maximum: 255 }
  validates :address_2, length: { maximum: 255 }
  validates :api_access, presence: true
  validates :api_key, length: { maximum: 255 }
  validates :city, length: { maximum: 255 }
  validates :company, length: { maximum: 255 }
  validates :country, length: { maximum: 255 }
  validates :current_sign_in_ip, length: { maximum: 255 }
  validates :email, length: { maximum: 255 }
  validates :first_name, length: { maximum: 255 }
  validates :last_name, length: { maximum: 255 }
  validates :last_sign_in_ip, length: { maximum: 255 }
  validates :password_hash, length: { maximum: 255 }
  validates :paypal_email, length: { maximum: 255 }
  validates :postal_code, length: { maximum: 255 }
  validates :region, length: { maximum: 255 }
  validates :reset_password_token, length: { maximum: 255 }
  validates :revenue_rate, numericality: { greater_than_or_equal_to: 0, allow_nil: false }
  validates :roles, inclusion: { in: ENUMS::USER_ROLES.values }
  validates :unlock_token, length: { maximum: 255 }

  # callbacks .................................................................

  # scopes ....................................................................
  scope :sponsor, -> { with_all_roles ENUMS::USER_ROLES::SPONSOR }
  scope :developer, -> { with_all_roles ENUMS::USER_ROLES::DEVELOPER }

  # Scopes and helpers provied by tag_columns
  # SEE: https://github.com/hopsoft/tag_columns
  #
  # - with_roles
  # - without_roles
  # - with_any_roles
  # - without_any_roles
  # - with_all_roles
  # - without_all_roles
  #
  # Examples
  #
  #   irb>User.with_roles(:admin)
  #   irb>User.without_any_roles(:sponsor, :developer)

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  tag_columns :roles

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def full_name
    "#{first_name} #{last_name}"
  end

  def detailed_name
    return full_name if company.blank?
    "#{company} ~ #{full_name}"
  end

  # protected instance methods ................................................
  protected

  # private instance methods ..................................................
  private
end
