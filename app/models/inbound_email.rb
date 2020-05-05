# == Schema Information
#
# Table name: inbound_emails
#
#  id                              :bigint           not null, primary key
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
  validates :action_mailbox_inbound_email_id, presence: true, uniqueness: true
  validates :delivered_at, presence: true
  validates :recipients, presence: true
  validates :sender, presence: true

  # callbacks .................................................................
  # scopes ....................................................................
  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def participant_addresses
    [sender, recipients].flatten.compact.sort    
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
end