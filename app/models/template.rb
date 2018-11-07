# frozen_string_literal: true

# == Schema Information
#
# Table name: templates
#
#  id          :bigint(8)        not null, primary key
#  name        :string           not null
#  description :text             not null
#  html        :text             not null
#  created_at  :datetime         not null
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
