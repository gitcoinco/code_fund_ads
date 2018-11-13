# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  roles                  :string           default([]), is an Array
#  first_name             :string           not null
#  last_name              :string           not null
#  company_name           :string
#  address_1              :string
#  address_2              :string
#  city                   :string
#  region                 :string
#  postal_code            :string
#  country                :string
#  api_access             :boolean          default(FALSE), not null
#  api_key                :string
#  paypal_email           :string
#  email                  :string           not null
#  encrypted_password     :string           not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  # extends ...................................................................

  # includes ..................................................................
  include Users::Presentable
  include Imageable
  include Taggable

  # relationships .............................................................
  has_many :assets
  has_many :campaigns
  has_many :creatives
  has_many :properties

  # validations ...............................................................
  validates :first_name, presence: true
  validates :last_name, presence: true

  # callbacks .................................................................
  before_save :ensure_roles

  # scopes ....................................................................
  scope :administrator, -> { with_all_roles ENUMS::USER_ROLES::ADMINISTRATOR }
  scope :advertiser, -> { with_all_roles ENUMS::USER_ROLES::ADVERTISER }
  scope :publisher, -> { with_all_roles ENUMS::USER_ROLES::PUBLISHER }
  scope :search_company, -> (value) { value.blank? ? all : search_column(:company_name, value) }
  scope :search_email, -> (value) { value.blank? ? all : search_column(:email, value) }
  scope :search_name, -> (value) { value.blank? ? all : search_column(:first_name, value).or(search_column(:last_name, value)) }
  scope :search_roles, -> (*values) { values.blank? ? all : with_any_roles(*values) }

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
  #   irb>User.without_any_roles(:advertiser, :publisher)

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  tag_columns :roles rescue ActiveRecord::NoDatabaseError # rescue required for initial migration due to devise
  devise(
    :confirmable,
    :database_authenticatable,
    :lockable,
    :recoverable,
    :registerable,
    :rememberable,
    :timeoutable,
    :trackable,
    :validatable,
  )

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def administrator?
    roles.include? ENUMS::USER_ROLES["administrator"]
  end

  def advertiser?
    roles.include? ENUMS::USER_ROLES["advertiser"]
  end

  def publisher?
    roles.include? ENUMS::USER_ROLES["publisher"]
  end

  def total_distributions
    250.00
  end

  # protected instance methods ................................................
  protected

  # private instance methods ..................................................
  private

    def ensure_roles
      self.roles = roles & ENUMS::USER_ROLES.values
    end
end
