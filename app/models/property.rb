# == Schema Information
#
# Table name: properties
#
#  id                          :bigint(8)        not null, primary key
#  user_id                     :bigint(8)        not null
#  property_type               :string           not null
#  status                      :string           not null
#  name                        :string           not null
#  description                 :text
#  url                         :text             not null
#  ad_template                 :string
#  ad_theme                    :string
#  language                    :string           not null
#  keywords                    :string           default([]), not null, is an Array
#  prohibited_advertisers      :bigint(8)        default([]), is an Array
#  prohibit_fallback_campaigns :boolean          default(FALSE), not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#

class Property < ApplicationRecord
  # extends ...................................................................

  # includes ..................................................................
  include Properties::Presentable
  include Taggable
  include Imageable

  # relationships .............................................................
  belongs_to :user
  has_many :impressions

  # validations ...............................................................
  # validates :ad_template, presence: true
  # validates :ad_theme, presence: true
  validates :language, length: {maximum: 255, allow_blank: false}
  validates :name, length: {maximum: 255, allow_blank: false}
  validates :property_type, inclusion: {in: ENUMS::PROPERTY_TYPES.values}
  validates :status, inclusion: {in: ENUMS::PROPERTY_STATUSES.values}
  validates :url, presence: true

  # callbacks .................................................................
  after_save :generate_screenshot

  # scopes ....................................................................
  scope :search_ad_template, ->(*values) { values.blank? ? all : where(ad_template: values) }
  scope :search_keywords, ->(*values) { values.blank? ? all : with_any_keywords(*values) }
  scope :search_language, ->(*values) { values.blank? ? all : where(language: values) }
  scope :search_name, ->(value) { value.blank? ? all : search_column(:name, value) }
  scope :search_property_type, ->(*values) { values.blank? ? all : where(property_type: values) }
  scope :search_status, ->(*values) { values.blank? ? all : where(status: values) }
  scope :search_url, ->(value) { value.blank? ? all : search_column(:url, value) }
  scope :search_user, ->(value) { value.blank? ? all : where(user_id: User.publisher.search_name(value)) }
  scope :search_user_id, ->(value) { value.blank? ? all : where(user_id: value) }

  # Scopes and helpers provied by tag_columns
  # SEE: https://github.com/hopsoft/tag_columns
  #
  # - with_all_included_prohibited_advertisers
  # - with_any_included_prohibited_advertisers
  # - with_included_prohibited_advertisers
  # - without_all_included_prohibited_advertisers
  # - without_any_included_prohibited_advertisers
  # - without_included_prohibited_advertisers
  #
  # - with_all_included_keywords
  # - with_any_included_keywords
  # - with_included_keywords
  # - without_all_included_keywords
  # - without_any_included_keywords
  # - without_included_keywords

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  tag_columns :prohibited_advertisers
  tag_columns :keywords
  has_one_attached :screenshot

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

  # private instance methods ..................................................
  private

  def generate_screenshot
    GeneratePropertyScreenshotJob.perform_later(id) if saved_change_to_url?
  end
end
