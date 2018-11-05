# frozen_string_literal: true

# == Schema Information
#
# Table name: creatives
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)        not null
#  name       :string           not null
#  headline   :string           not null
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
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
