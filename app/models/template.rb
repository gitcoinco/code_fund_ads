# == Schema Information
#
# Table name: templates
#
#  id          :uuid             not null, primary key
#  name        :string(255)
#  slug        :string(255)
#  description :text
#  body        :text
#  inserted_at :datetime         not null
#  updated_at  :datetime         not null
#

class Template < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  has_many :properties
  has_many :themes

  # validations ...............................................................
  validates :name, length: { maximum: 255, allow_blank: false }
  validates :slug, length: { maximum: 255, allow_blank: false }

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
