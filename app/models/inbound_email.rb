# == Schema Information
#
# Table name: inbound_emails
#
#  id                              :bigint           not null, primary key
#  body                            :text
#  delivered_at                    :datetime         not null
#  recipients                      :text             default([]), not null, is an Array
#  sender                          :string           not null
#  snippet                         :text
#  subject                         :text
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  action_mailbox_inbound_email_id :bigint           not null
#
class InboundEmail < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  has_and_belongs_to_many :users

  # validations ...............................................................
  validates :delivered_at, presence: true
  validates :recipients, presence: true
  validates :sender, presence: true

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

  # protected instance methods ................................................

  # private instance methods ..................................................
end
