# frozen_string_literal: true

# == Schema Information
#
# Table name: creatives
#
#  user_id     :uuid
#  id          :uuid             not null, primary key
#  name        :string(255)
#  body        :string(255)
#  inserted_at :datetime         not null
#  updated_at  :datetime         not null
#  headline    :string(255)
#

class Creative < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :user
  has_many :campaigns

  # validations ...............................................................
  validates :body, length: { maximum: 255, allow_blank: false }
  validates :headline, length: { maximum: 255, allow_blank: false }
  validates :name, length: { maximum: 255, allow_blank: false }

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
