# == Schema Information
#
# Table name: emails
#
#  id                              :bigint           not null, primary key
#  body                            :text
#  delivered_at                    :datetime         not null
#  delivered_at_date               :date             not null
#  direction                       :string           default("inbound"), not null
#  in_reply_to                     :string
#  recipients                      :string           default([]), not null, is an Array
#  sender                          :string
#  snippet                         :text
#  subject                         :text
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  action_mailbox_inbound_email_id :bigint           not null
#  message_id                      :string
#  parent_id                       :bigint
#
# Indexes
#
#  index_emails_on_delivered_at_date  (delivered_at_date)
#  index_emails_on_delivered_at_hour  (date_trunc('hour'::text, delivered_at))
#  index_emails_on_parent_id          (parent_id)
#  index_emails_on_recipients         (recipients) USING gin
#  index_emails_on_sender             (sender)
#
class Email < ApplicationRecord
  # extends ...................................................................

  # includes ..................................................................
  include Emails::Presentable

  # relationships .............................................................
  has_many :email_users
  has_many :users, through: :email_users

  # validations ...............................................................
  validates :delivered_at, presence: true
  validates :recipients, presence: true
  validates :sender, presence: true
  validates :direction, presence: true, inclusion: {in: ENUMS::EMAIL_DIRECTIONS.values}
  validates :message_id, presence: true, uniqueness: true

  # callbacks .................................................................

  # scopes ....................................................................
  scope :inbound, -> { where(direction: ENUMS::EMAIL_DIRECTIONS::INBOUND) }
  scope :outbound, -> { where(direction: ENUMS::EMAIL_DIRECTIONS::OUTBOUND) }
  scope :unread_by, ->(user) { where(email_users: {user: user, read_at: nil}) }
  scope :read_by, ->(user) { where(email_users: {user: user}).where.not(email_users: {read_at: nil}) }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  has_closure_tree # see https://github.com/ClosureTree/closure_tree#accessing-data
  has_rich_text :body
  has_many_attached :attachments

  # class methods .............................................................

  # public instance methods ...................................................

  def inbound?
    direction == ENUMS::EMAIL_DIRECTIONS::INBOUND
  end

  def outbound?
    direction == ENUMS::EMAIL_DIRECTIONS::OUTBOUND
  end

  def participant_addresses
    [sender, recipients].flatten.compact.sort
  end

  def participant_users
    User.where(email: participant_addresses)
  end

  def sending_user
    @sending_user ||= User.find_by(email: sender)
  end

  def non_admin_users
    participant_users.non_administrators
  end

  def participating_organizations
    non_admin_users.map(&:default_organization).compact.sort
  end

  def inbound_email
    ActionMailbox::InboundEmail.find_by(id: action_mailbox_inbound_email_id)
  end

  def mark_read_for_user!(user)
    return unless user
    email_users.find_by(user: user).update!(read_at: Time.current)
  end

  def mark_unread_for_user!(user)
    return unless user
    email_users.find_by(user: user).update!(read_at: nil)
  end

  def read_by?(user)
    email_users.find_by(user: user).read_at
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end
