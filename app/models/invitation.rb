# == Schema Information
#
# Table name: invitations
#
#  id          :uuid             not null, primary key
#  email       :string(255)
#  token       :string(255)
#  inserted_at :datetime         not null
#  updated_at  :datetime         not null
#  first_name  :string(255)
#  last_name   :string(255)
#

class Invitation < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  # relationships .............................................................

  # validations ...............................................................
  validates :email, length: { maximum: 255, allow_blank: false }
  validates :first_name, length: { maximum: 255, allow_blank: false }
  validates :last_name, length: { maximum: 255, allow_blank: false }
  validates :token, length: { maximum: 255, allow_blank: false }

  # callbacks .................................................................
  # scopes ....................................................................
  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  # protected instance methods ................................................
  protected

  # private instance methods ..................................................
  private
end
