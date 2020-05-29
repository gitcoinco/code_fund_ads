# == Schema Information
#
# Table name: email_users
#
#  id       :bigint           not null, primary key
#  read_at  :datetime
#  email_id :bigint           not null
#  user_id  :bigint           not null
#
# Indexes
#
#  index_email_users_on_email_id_and_user_id  (email_id,user_id) UNIQUE
#
class EmailUser < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :email
  belongs_to :user

  # validations ...............................................................
  validates :email_id, presence: true
  validates :user_id, presence: true

  # callbacks .................................................................
  # scopes ....................................................................
  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
end
