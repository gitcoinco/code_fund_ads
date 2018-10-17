# == Schema Information
#
# Table name: audiences
#
#  id                    :uuid             not null, primary key
#  name                  :string(255)      not null
#  programming_languages :string(255)      default([]), is an Array
#  inserted_at           :datetime         not null
#  updated_at            :datetime         not null
#  topic_categories      :string(255)      default([]), is an Array
#  fallback_campaign_id  :uuid
#

class Audience < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :fallback_campaign

  # validations ...............................................................
  validates :name, length: { maximum: 255, allow_blank: false }
  validates :programming_languages, length: { maximum: 255, allow_blank: false }
  validates :topic_categories, length: { maximum: 255, allow_blank: false }

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
