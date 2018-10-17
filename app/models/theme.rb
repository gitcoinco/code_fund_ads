# == Schema Information
#
# Table name: themes
#
#  template_id :uuid
#  id          :uuid             not null, primary key
#  name        :string(255)
#  slug        :string(255)
#  description :text
#  body        :text
#  inserted_at :datetime         not null
#  updated_at  :datetime         not null
#

class Theme < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :template

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
