# frozen_string_literal: true

# == Schema Information
#
# Table name: properties
#
#  id                          :bigint(8)        not null, primary key
#  user_id                     :bigint(8)        not null
#  template_id                 :uuid
#  type                        :string           not null
#  status                      :string           not null
#  name                        :string           not null
#  description                 :text
#  url                         :text             not null
#  language                    :string           not null
#  keywords                    :string           default([]), not null, is an Array
#  prohibited_advertisers      :bigint(8)        default([]), is an Array
#  prohibit_fallback_campaigns :boolean          default(FALSE), not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#

class Property < ApplicationRecord
  include Taggable

  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :template
  belongs_to :user
  has_many :impressions

  # validations ...............................................................
  validates :language, length: { maximum: 255, allow_blank: false }
  validates :legacy_id, length: { maximum: 255 }
  validates :name, length: { maximum: 255, allow_blank: false }
  validates :no_api_house_ads, presence: true
  validates :programming_languages, length: { maximum: 255, allow_blank: false }
  validates :property_type, inclusion: { in: ENUMS::PROPERTY_TYPES.keys }
  validates :slug, length: { maximum: 255, allow_blank: false }
  validates :status, inclusion: { in: ENUMS::PROPERTY_STATUSES.keys }
  validates :topic_categories, length: { maximum: 255, allow_blank: false }
  validates :url, presence: true

  # callbacks .................................................................

  # scopes ....................................................................
  scope :search_languages, -> (*values) { values.blank? ? all : where(language: values) }
  scope :search_name, -> (value) { value.blank? ? all : search_column(:name, value) }
  scope :search_programming_languages, -> (*values) { values.blank? ? all : with_any_programming_languages(*values) }
  scope :search_property_type, -> (*values) { values.blank? ? all : where(property_type: values) }
  scope :search_status, -> (*values) { values.blank? ? all : where(status: values) }
  scope :search_template, -> (*values) { values.blank? ? all : where(template_id: values) }
  scope :search_topic_categories, -> (*values) { values.blank? ? all : with_any_topic_categories(*values) }
  scope :search_user, -> (value) { value.blank? ? all : where(user_id: User.developer.search_name(value)) }

  # Scopes and helpers provied by tag_columns
  # SEE: https://github.com/hopsoft/tag_columns
  #
  # - with_all_included_excluded_advertisers
  # - with_any_included_excluded_advertisers
  # - with_included_excluded_advertisers
  # - without_all_included_excluded_advertisers
  # - without_any_included_excluded_advertisers
  # - without_included_excluded_advertisers
  #
  # - with_all_included_programming_languages
  # - with_any_included_programming_languages
  # - with_included_programming_languages
  # - without_all_included_programming_languages
  # - without_any_included_programming_languages
  # - without_included_programming_languages
  #
  # - with_all_included_topic_categories
  # - with_any_included_topic_categories
  # - with_included_topic_categories
  # - without_all_included_topic_categories
  # - without_any_included_topic_categories
  # - without_included_topic_categories

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  tag_columns :excluded_advertisers
  tag_columns :programming_languages
  tag_columns :topic_categories

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def scoped_name
    [user.scoped_name, name].compact.join "・"
  end

  def favicon_image_url
    domain = url.gsub(/^https?:\/\//, "")
    "//www.google.com/s2/favicons?domain=#{domain}"
  end

  def pretty_url
    url.gsub(/^https?:\/\//, "").gsub("www.", "").split("/").first
  end

  # protected instance methods ................................................
  protected

  # private instance methods ..................................................
  private
end
