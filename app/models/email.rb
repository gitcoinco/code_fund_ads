# == Schema Information
#
# Table name: emails
#
#  id                              :bigint           not null, primary key
#  body                            :text
#  delivered_at                    :datetime         not null
#  direction                       :integer          default("inbound")
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
#  index_emails_on_recipients  (recipients) USING gin
#  index_emails_on_sender      (sender)
#
class Email < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  has_and_belongs_to_many :users

  # validations ...............................................................
  validates :delivered_at, presence: true
  validates :recipients, presence: true
  validates :sender, presence: true
  validates :direction, presence: true

  # callbacks .................................................................
  # scopes ....................................................................

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  enum direction: {inbound: 0, outbound: 1}
  has_rich_text :body
  has_many_attached :attachments

  # class methods .............................................................

  # public instance methods ...................................................
  def participant_addresses
    [sender, recipients].flatten.compact.sort
  end

  def sending_user
    @sender ||= User.find_by(email: sender)
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end
