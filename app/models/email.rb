# == Schema Information
#
# Table name: emails
#
#  id           :bigint           not null, primary key
#  cc_addresses :text             default([]), is an Array
#  content      :text             not null
#  delivered_at :datetime         not null
#  from_address :string           not null
#  subject      :string           not null
#  to_addresses :text             default([]), is an Array
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  message_id   :string           not null
#
# Indexes
#
#  index_emails_on_cc_addresses  (cc_addresses) USING gin
#  index_emails_on_from_address  (from_address)
#  index_emails_on_message_id    (message_id) UNIQUE
#  index_emails_on_to_addresses  (to_addresses) USING gin
#
class Email < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  # relationships .............................................................

  # validations ...............................................................
  validates :message_id, presence: true
  validates :from_address, presence: true
  validates :subject, presence: true
  validates :to_addresses, presence: true
  validates :delivered_at, presence: true
  validates :content, presence: true
  
  # callbacks .................................................................
  # scopes ....................................................................
  scope :with_email, ->(email) { where("from_address = ? OR (? = ANY (to_addresses)) OR (? = ANY (cc_addresses))", email, email, email) }
  scope :with_user, ->(user) { with_email(user.email) }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
end
