# == Schema Information
#
# Table name: applicants
#
#  id                :bigint(8)        not null, primary key
#  status            :string           default("pending")
#  role              :string           not null
#  email             :string           not null
#  canonical_email   :string           not null
#  first_name        :string           not null
#  last_name         :string           not null
#  url               :string           not null
#  monthly_visitors  :string
#  company_name      :string
#  monthly_budget    :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  invited_user_id   :bigint(8)
#  referring_user_id :bigint(8)
#

class Applicant < ApplicationRecord
  # extends ...................................................................

  # includes ..................................................................
  include Applicants::Presentable
  include Eventable

  # relationships .............................................................
  belongs_to :referring_user, class_name: "User", foreign_key: "referring_user_id", optional: true

  # validations ...............................................................
  validates :role, presence: true, inclusion: {in: ENUMS::APPLICANT_ROLES.values}
  validates :status, presence: true, inclusion: {in: ENUMS::APPLICANT_STATUSES.values}
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_with EmailAddress::ActiveRecordValidator, fields: %i[email canonical_email]
  validates :url, presence: true, url: true
  with_options if: :for_publisher? do |publisher|
    publisher.validates :monthly_visitors, presence: true
  end
  with_options if: :for_advertiser? do |advertiser|
    advertiser.validates :company_name, presence: true
    advertiser.validates :monthly_budget, presence: true
  end

  # callbacks .................................................................
  after_commit :send_notifications, on: [:create]
  after_commit :convert_to_invitation, on: [:update]

  # scopes ....................................................................

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  acts_as_commentable
  attr_accessor :subject, :body, :organization_id

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def invited_user
    @invited_user ||= User.where(id: invited_user_id).first
  end

  def email=(email_address)
    self[:canonical_email] = email_address
    self[:email] = email_address
  end

  def self.find_by_email(email)
    user   = find_by(email: EmailAddress.normal(email))
    user ||= find_by(canonical_email: EmailAddress.canonical(email))
    user ||= find_by(canonical_email: EmailAddress.redacted(email))
    user
  end

  def redact!
    self[:canonical_email] = EmailAddress.redact(canonical_email)
    self[:email]           = self[:canonical_email]
  end

  def for_publisher?
    role == "publisher"
  end

  def for_advertiser?
    role == "advertiser"
  end

  def liquid_attributes
    slice(
      :company_name,
      :email,
      :first_name,
      :last_name,
      :monthly_budget,
      :monthly_visitors,
      :role,
      :url
    )
  end

  def to_s
    "#{role.humanize} Applicant [#{first_name} #{last_name}]"
  end

  def user_id
    @user_id ||= (User.where(email: "eric@codefund.io").first || User.administrator.first).id
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
  private

  def send_notifications
    notify_slack_of_publisher_applicant if for_publisher?
    notify_slack_of_advertiser_applicant if for_advertiser?
  end

  def notify_slack_of_publisher_applicant
    CreateSlackNotificationJob.perform_later(
      text: "<!channel> *Publisher Form Submission*",
      message: <<~MESSAGE
        *First Name:* #{first_name}
        *Last Name:*  #{last_name}
        *Email:*  #{email}
        *Monthly Visitors:*  #{monthly_visitors}
        *Website:*  #{url}
        *Referring User:* #{referring_user&.full_name}
      MESSAGE
    )
  end

  def notify_slack_of_advertiser_applicant
    CreateSlackNotificationJob.perform_later(
      text: "<!channel> *Advertiser Form Submission*",
      message: <<~MESSAGE
        *First Name:* #{first_name}
        *Last Name:* #{last_name}
        *Email:* #{email}
        *Company:* #{company_name}
        *Est. Budget:* #{monthly_budget}
        *Website:* #{url}
        *Referring User:* #{referring_user&.full_name}
      MESSAGE
    )
  end

  def convert_to_invitation
    return if invited_user_id
    return unless status == ENUMS::APPLICANT_STATUSES::ACCEPTED

    user = User.invite!(
      first_name: first_name,
      last_name: last_name,
      email: email,
      organization_id: organization_id,
      roles: [role],
      referring_user_id: referring_user_id,
    )

    update_attribute(:invited_user_id, user.id)
    add_event("Sent invitation", ["email"])

    AddToMailchimpListJob.perform_later email, user.id
  end
end
