# == Schema Information
#
# Table name: emails
#
#  id                              :bigint           not null, primary key
#  body                            :text
#  delivered_at                    :datetime         not null
#  delivered_at_date               :date             not null
#  direction                       :string           default("inbound"), not null
#  recipients                      :string           default([]), not null, is an Array
#  sender                          :string
#  snippet                         :text
#  subject                         :text
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  action_mailbox_inbound_email_id :bigint           not null
#
# Indexes
#
#  index_emails_on_delivered_at_date  (delivered_at_date)
#  index_emails_on_delivered_at_hour  (date_trunc('hour'::text, delivered_at))
#  index_emails_on_recipients         (recipients) USING gin
#  index_emails_on_sender             (sender)
#
class Email < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  has_many :email_users
  has_many :users, through: :email_users

  # validations ...............................................................
  validates :delivered_at, presence: true
  validates :recipients, presence: true
  validates :sender, presence: true
  validates :direction, presence: true, inclusion: {in: ENUMS::EMAIL_DIRECTIONS.values}

  # callbacks .................................................................
  # scopes ....................................................................

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  has_rich_text :body
  has_many_attached :attachments

  # class methods .............................................................

  # public instance methods ...................................................
  def participant_addresses
    [sender, recipients].flatten.compact.sort
  end

  def participant_users
    User.where(email: participant_addresses)
  end

  def sending_user
    @sender ||= User.find_by(email: sender)
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end
