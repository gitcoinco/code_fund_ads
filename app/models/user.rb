# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  address_1              :string
#  address_2              :string
#  api_access             :boolean          default(FALSE), not null
#  api_key                :string
#  bio                    :text
#  city                   :string
#  company_name           :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  country                :string
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           not null
#  encrypted_password     :string           not null
#  failed_attempts        :integer          default(0), not null
#  first_name             :string           not null
#  github_username        :string
#  invitation_accepted_at :datetime
#  invitation_created_at  :datetime
#  invitation_limit       :integer
#  invitation_sent_at     :datetime
#  invitation_token       :string
#  invitations_count      :integer          default(0)
#  invited_by_type        :string
#  last_name              :string           not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  linkedin_username      :string
#  locked_at              :datetime
#  paypal_email           :string
#  postal_code            :string
#  record_inbound_emails  :boolean          default(FALSE)
#  referral_click_count   :integer          default(0)
#  referral_code          :string
#  region                 :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  roles                  :string           default([]), is an Array
#  sign_in_count          :integer          default(0), not null
#  skills                 :text             default([]), is an Array
#  status                 :string           default("active")
#  twitter_username       :string
#  unconfirmed_email      :string
#  unlock_token           :string
#  us_resident            :boolean          default(FALSE)
#  utm_campaign           :string
#  utm_content            :string
#  utm_medium             :string
#  utm_source             :string
#  utm_term               :string
#  website_url            :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invited_by_id          :bigint
#  legacy_id              :uuid
#  organization_id        :bigint
#  referring_user_id      :bigint
#  stripe_customer_id     :string
#
# Indexes
#
#  index_users_on_confirmation_token                 (confirmation_token) UNIQUE
#  index_users_on_email                              (lower((email)::text)) UNIQUE
#  index_users_on_invitation_token                   (invitation_token) UNIQUE
#  index_users_on_invitations_count                  (invitations_count)
#  index_users_on_invited_by_id                      (invited_by_id)
#  index_users_on_invited_by_type_and_invited_by_id  (invited_by_type,invited_by_id)
#  index_users_on_organization_id                    (organization_id)
#  index_users_on_referral_code                      (referral_code) UNIQUE
#  index_users_on_referring_user_id                  (referring_user_id)
#  index_users_on_reset_password_token               (reset_password_token) UNIQUE
#  index_users_on_unlock_token                       (unlock_token) UNIQUE
#

class User < ApplicationRecord
  # extends ...................................................................

  # includes ..................................................................
  include Users::Developable if Rails.env.development?
  include Users::Advertiser
  include Users::Publisher
  include Users::Presentable
  include Users::Stripeable
  include Eventable
  include FullNameSplitter
  include Imageable
  include Taggable

  # relationships .............................................................
  belongs_to :organization, optional: true
  belongs_to :referring_user, class_name: "User", foreign_key: "referring_user_id", optional: true
  has_many :job_postings
  has_many :organization_users, dependent: :destroy, inverse_of: :user
  has_many :organizations_as_administrator, -> { where organization_users: {role: ENUMS::ORGANIZATION_ROLES::ADMINISTRATOR} }, through: :organization_users, source: "organization"
  has_many :organizations_as_member, -> { where organization_users: {role: ENUMS::ORGANIZATION_ROLES::MEMBER} }, through: :organization_users, source: "organization"
  has_many :organizations, through: :organization_users
  has_many :referred_users, class_name: "User", foreign_key: "referring_user_id"
  has_many :managed_accounts, class_name: "Organization", foreign_key: "account_manager_user_id"
  has_many :email_users
  has_many :emails, through: :email_users
  has_many :pixels
  has_many :pixel_conversions

  # validations ...............................................................
  validates :first_name, presence: true
  validates :last_name, presence: true

  # callbacks .................................................................
  before_save :ensure_roles
  before_save :ensure_referral_code
  before_destroy :destroy_paper_trail_versions

  # scopes ....................................................................
  scope :administrators, -> { with_all_roles ENUMS::USER_ROLES::ADMINISTRATOR }
  scope :advertisers, -> { with_all_roles ENUMS::USER_ROLES::ADVERTISER }
  scope :publishers, -> { with_all_roles ENUMS::USER_ROLES::PUBLISHER }
  scope :account_managers, -> { with_all_roles ENUMS::USER_ROLES::ACCOUNT_MANAGER }
  scope :non_administrators, -> { without_any_roles ENUMS::USER_ROLES::ADMINISTRATOR }
  scope :search_company, ->(value) { value.blank? ? all : search_column(:company_name, value) }
  scope :search_organization, ->(value) { value.blank? ? all : where(organization_id: value) }
  scope :search_email, ->(value) { value.blank? ? all : search_column(:email, value) }
  scope :search_name, ->(value) { value.blank? ? all : search_column(:first_name, value).or(search_column(:last_name, value)) }
  scope :search_roles, ->(*values) { values.blank? ? all : with_any_roles(*values) }
  scope :with_active_campaigns, -> {
    advertisers.distinct.joins(:campaigns).where(campaigns: {status: ENUMS::CAMPAIGN_STATUSES::ACTIVE})
  }

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

  # Scopes and helpers provied by devise_invitable
  # SEE: https://github.com/scambra/devise_invitable
  #
  # - invitation_accepted
  # - invitation_not_accepted
  # - created_by_invite
  # - created_by_invite?        # Verify wheather a user is created by invitation, irrespective to invitation status
  # - invited_to_sign_up?       # Verifies whether a user has been invited or not
  # - accepting_invitation?     # Returns true if accept_invitation! was called
  # - invitation_accepted?      # Verifies whether a user accepted an invitation (false when user is accepting it)
  # - accepted_or_not_invited?  # Verifies whether a user has accepted an invitation (false when user is accepting it), or was never invited
  #
  # Examples
  #
  #   irb>User.invitation_accepted
  #   irb>User.invitation_not_accepted
  #   irb>User.created_by_invite

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  begin
    tag_columns :roles
    tag_columns :skills
  rescue
    # rescue required for initial migration due to devise
    ActiveRecord::NoDatabaseError
  end

  devise(
    :confirmable,
    :database_authenticatable,
    :invitable,
    :lockable,
    :recoverable,
    :rememberable,
    :timeoutable,
    :trackable,
    :validatable
  )
  has_one_attached :avatar
  accepts_nested_attributes_for :organization_users, reject_if: proc { |attributes| attributes["organization_id"].blank? || attributes["role"].blank? }
  acts_as_commentable
  has_paper_trail on: %i[update], only: %i[
    api_access
    api_key
    company_name
    email
    first_name
    last_name
    roles
  ]

  # class methods .............................................................
  class << self
    def authenticate(email, password)
      user = User.find_for_authentication(email: email)
      user&.valid_password?(password) ? user : nil
    end

    def find_version_author(version)
      return unless version.terminator
      find(version.terminator)
    end

    def codefund_bot
      pw = SecureRandom.uuid
      where(email: "bot@codefund.io").first_or_create!(
        first_name: "CodeFund",
        last_name: "Bot",
        password: pw,
        password_confirmation: pw,
        organization: Organization.codefund,
        invitation_accepted_at: Time.current
      )
    end

    def referral_code(user_id)
      where(id: user_id).limit(1).pluck(:referral_code).first
    end
  end

  # public instance methods ...................................................

  def organization
    ActiveSupport::Deprecation.warn("User#organization is being deprecated and should not be used")
    super
  end

  def default_organization
    organizations.load unless organizations.loaded?
    ou = organization_users.find(&:administrator?) || organization_users.find(&:member?)
    ou&.organization || organization
  end

  def administrator?
    roles.include? ENUMS::USER_ROLES::ADMINISTRATOR
  end

  def employer?
    roles.include? ENUMS::USER_ROLES::EMPLOYER
  end

  def blacklisted?
    status == ENUMS::USER_STATUSES::BLACKLISTED
  end

  def to_s
    full_name
  end

  # Deliver Devise emails via Sidekiq
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def referral_revenue
    value = referred_users.publishers.sum { |user|
      user.property_revenue(user.created_at, user.created_at.advance(months: 3)) * 0.05
    }
    value = Monetize.parse("$0.00 USD") unless value.is_a?(Money)
    value
  end

  def active_for_authentication?
    super && !blacklisted?
  end

  # protected instance methods ................................................
  protected

  # private instance methods ..................................................
  private

  def ensure_roles
    self.roles = roles & ENUMS::USER_ROLES.values
  end

  def ensure_referral_code
    self.referral_code ||= begin
      code = SecureRandom.urlsafe_base64(8)
      code = SecureRandom.urlsafe_base64(8) while User.where(referral_code: code).exists?
      code
    end
  end

  def destroy_paper_trail_versions
    PaperTrail::Version.where(id: versions.select(:id)).delete_all
  end
end
