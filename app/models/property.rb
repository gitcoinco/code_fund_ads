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
#  prohibited_advertiser_ids   :bigint(8)        default([]), not null, is an Array
#  prohibit_fallback_campaigns :boolean          default(FALSE), not null
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  legacy_id                   :uuid
#  revenue_percentage          :decimal(, )      default(0.5), not null
#

class Property < ApplicationRecord
  # extends ...................................................................

  # includes ..................................................................
  include Properties::Presentable
  include Eventable
  include Taggable
  include Imageable
  include Impressionable

  # relationships .............................................................
  belongs_to :user
  has_many :property_advertisers
  has_many :advertisers, through: :property_advertisers, class_name: "User", foreign_key: "advertiser_id"

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
  scope :active, -> { where status: ENUMS::PROPERTY_STATUSES::ACTIVE }
  scope :archived, -> { where status: ENUMS::PROPERTY_STATUSES::ARCHIVED }
  scope :blacklisted, -> { where status: ENUMS::PROPERTY_STATUSES::BLACKLISTED }
  scope :pending, -> { where status: ENUMS::PROPERTY_STATUSES::PENDING }
  scope :rejected, -> { where status: ENUMS::PROPERTY_STATUSES::REJECTED }
  scope :search_ad_template, ->(*values) { values.blank? ? all : where(ad_template: values) }
  scope :search_keywords, ->(*values) { values.blank? ? all : with_any_keywords(*values) }
  scope :exclude_keywords, ->(*values) { values.blank? ? all : without_any_keywords(*values) }
  scope :search_language, ->(*values) { values.blank? ? all : where(language: values) }
  scope :search_name, ->(value) { value.blank? ? all : search_column(:name, value) }
  scope :search_property_type, ->(*values) { values.blank? ? all : where(property_type: values) }
  scope :search_status, ->(*values) { values.blank? ? all : where(status: values) }
  scope :search_url, ->(value) { value.blank? ? all : search_column(:url, value) }
  scope :search_user, ->(value) { value.blank? ? all : where(user_id: User.publishers.search_name(value)) }
  scope :search_user_id, ->(value) { value.blank? ? all : where(user_id: value) }
  scope :for_campaign, ->(campaign) {
    relation = active.with_any_keywords(*campaign.keywords).without_any_keywords(*campaign.negative_keywords)
    relation = relation.where(prohibit_fallback_campaigns: false) if campaign.fallback?
    relation = relation.without_all_prohibited_advertiser_ids(campaign.id)
    relation
  }

  # Scopes and helpers provied by tag_columns
  # SEE: https://github.com/hopsoft/tag_columns
  #
  # - with_all_prohibited_advertiser_ids
  # - with_any_prohibited_advertiser_ids
  # - with_prohibited_advertiser_ids
  # - without_all_prohibited_advertiser_ids
  # - without_any_prohibited_advertiser_ids
  # - without_prohibited_advertiser_ids
  #
  # - with_all_keywords
  # - with_any_keywords
  # - with_keywords
  # - without_all_keywords
  # - without_any_keywords
  # - without_keywords

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  tag_columns :prohibited_advertiser_ids
  tag_columns :keywords
  has_one_attached :screenshot
  acts_as_commentable
  has_paper_trail on: %i[update destroy], only: %i[
    ad_template
    ad_theme
    keywords
    language
    prohibit_fallback_campaigns
    prohibited_advertiser_ids
    name
    property_type
    status
    url
    user_id
  ]

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  # Intentionally override relationship to improve query performance.
  # Query performance without joining on property_advertisers will be
  # problematic since all partition tables would be scanned
  def impressions
    Impression.where(advertiser_id: property_advertisers.select(:advertiser_id))
  end

  def favicon_image_url
    domain = url.gsub(/^https?:\/\//, "")
    "//www.google.com/s2/favicons?domain=#{domain}"
  end

  def pretty_url
    url.gsub(/^https?:\/\//, "").gsub("www.", "").split("/").first
  end

  def matching_campaigns
    Campaign.for_property self
  end

  def displayed_campaigns(start_date = nil, end_date = nil)
    subquery = impressions.between(start_date, end_date).distinct(:campaign_id).select(:campaign_id) if start_date
    subquery ||= impressions.distinct(:campaign_id).select(:campaign_id)
    Campaign.where id: subquery
  end

  def clicked_campaigns(start_date = nil, end_date = nil)
    subquery = impressions.clicked.between(start_date, end_date).distinct(:campaign_id).select(:campaign_id) if start_date
    subquery ||= impressions.clicked.distinct(:campaign_id).select(:campaign_id)
    Campaign.where id: subquery
  end

  def revenue_calculators(start_date = nil, end_date = nil)
    campaigns = displayed_campaigns(start_date, end_date).includes(:user)
    probable_dates_with_impressions(start_date, end_date).each_with_object([]) do |date, memo|
      campaigns.each do |campaign|
        memo << DailyRevenueCalculator.new(date, self, campaign)
      end
    end
  end

  def gross_revenue(start_date = nil, end_date = nil)
    revenue_calculators(start_date, end_date).sum(&:gross_revenue)
  end

  def property_revenue(start_date = nil, end_date = nil)
    revenue_calculators(start_date, end_date).sum(&:property_revenue)
  end

  def house_revenue(start_date = nil, end_date = nil)
    revenue_calculators(start_date, end_date).sum(&:house_revenue)
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
  private

  def generate_screenshot
    GeneratePropertyScreenshotJob.perform_later(id) if saved_change_to_url?
  end
end
