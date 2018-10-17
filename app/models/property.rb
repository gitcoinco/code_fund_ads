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
#  audience_id                  :uuid
#  excluded_advertisers         :string(255)      default([]), is an Array
#  template_id                  :uuid
#  no_api_house_ads             :boolean          default(FALSE), not null
#

class Property < ApplicationRecord
  PROPERTY_TYPES = {
    website: 1,
    repository: 2,
    newsletter: 3
  }.freeze

  STATUSES = {
    pending: 0,
    active: 1,
    rejected: 2,
    archived: 3,
    blacklisted: 4
  }.freeze

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
  validates :property_type, inclusion: { in: PROPERTY_TYPES.values }
  validates :slug, length: { maximum: 255, allow_blank: false }
  validates :status, inclusion: { in: STATUSES.values }
  validates :topic_categories, length: { maximum: 255, allow_blank: false }
  validates :url, presence: true

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
