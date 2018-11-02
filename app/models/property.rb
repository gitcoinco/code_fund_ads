# frozen_string_literal: true

# == Schema Information
#
# Table name: properties
#
#  id                           :uuid             not null, primary key
#  legacy_id                    :string(255)
#  name                         :string(255)      not null
#  url                          :text             not null
#  description                  :text
#  property_type                :integer          not null
#  user_id                      :uuid
#  inserted_at                  :datetime         not null
#  updated_at                   :datetime         not null
#  status                       :integer          default(0)
#  estimated_monthly_page_views :integer
#  estimated_monthly_visitors   :integer
#  alexa_site_rank              :integer
#  language                     :string(255)      not null
#  programming_languages        :string(255)      default([]), not null, is an Array
#  topic_categories             :string(255)      default([]), not null, is an Array
#  screenshot_url               :text
#  slug                         :string(255)      not null
#  excluded_advertisers         :string(255)      default([]), is an Array
#  template_id                  :uuid
#  no_api_house_ads             :boolean          default(FALSE), not null
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
