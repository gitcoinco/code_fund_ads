# == Schema Information
#
# Table name: properties
#
#  id                             :bigint           not null, primary key
#  user_id                        :bigint           not null
#  property_type                  :string           not null
#  status                         :string           not null
#  name                           :string           not null
#  description                    :text
#  url                            :text             not null
#  ad_template                    :string
#  ad_theme                       :string
#  language                       :string           not null
#  keywords                       :string           default([]), not null, is an Array
#  prohibited_advertiser_ids      :bigint           default([]), not null, is an Array
#  prohibit_fallback_campaigns    :boolean          default(FALSE), not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  legacy_id                      :uuid
#  revenue_percentage             :decimal(, )      default(0.6), not null
#  assigned_fallback_campaign_ids :bigint           default([]), not null, is an Array
#  restrict_to_assigner_campaigns :boolean          default(FALSE), not null
#  fallback_ad_template           :string
#  fallback_ad_theme              :string
#  responsive_behavior            :string           default("none"), not null
#  audience                       :string
#

class Property < ApplicationRecord
  # extends ...................................................................

  # includes ..................................................................
  include Properties::Impressionable
  include Properties::Presentable
  include Eventable
  include Imageable
  include Impressionable
  include Keywordable
  include Sparklineable
  include Taggable

  # relationships .............................................................
  belongs_to :user
  has_many :advertisers, through: :property_advertisers, class_name: "User", foreign_key: "advertiser_id"
  has_many :property_advertisers, dependent: :destroy
  has_many :property_traffic_estimates, dependent: :destroy

  # validations ...............................................................
  # validates :ad_template, presence: true
  # validates :ad_theme, presence: true
  validates :language, length: {maximum: 255, allow_blank: false}
  validates :name, length: {maximum: 255, allow_blank: false}
  validates :property_type, inclusion: {in: ENUMS::PROPERTY_TYPES.values}
  validates :status, inclusion: {in: ENUMS::PROPERTY_STATUSES.values}
  validates :responsive_behavior, inclusion: {in: ENUMS::PROPERTY_RESPONSIVE_BEHAVIORS.values}
  validates :audience, inclusion: {in: Audience.all.map(&:name)}
  validates :url, presence: true, url: true

  # callbacks .................................................................
  before_validation :assign_audience
  before_save :sanitize_assigned_fallback_campaign_ids
  after_save :generate_screenshot
  before_destroy :destroy_paper_trail_versions

  # scopes ....................................................................
  scope :active, -> { where status: ENUMS::PROPERTY_STATUSES::ACTIVE }
  scope :archived, -> { where status: ENUMS::PROPERTY_STATUSES::ARCHIVED }
  scope :blacklisted, -> { where status: ENUMS::PROPERTY_STATUSES::BLACKLISTED }
  scope :pending, -> { where status: ENUMS::PROPERTY_STATUSES::PENDING }
  scope :rejected, -> { where status: ENUMS::PROPERTY_STATUSES::REJECTED }
  scope :website, -> { where property_type: ENUMS::PROPERTY_TYPES::WEBSITE }
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
  scope :without_estimates, -> {
    subquery = PropertyTrafficEstimate.select(:property_id)
    where.not(id: subquery)
  }
  scope :for_campaign, ->(campaign) {
    relation = active.with_any_keywords(*campaign.keywords).without_any_keywords(*campaign.negative_keywords)
    relation = relation.where(prohibit_fallback_campaigns: false) if campaign.fallback?
    relation = relation.without_all_prohibited_advertiser_ids(campaign.id)
    relation
  }
  scope :with_assigned_fallback_campaign_id, ->(campaign_id) {
    value = Arel::Nodes::SqlLiteral.new(sanitize_sql_array(["ARRAY[?]", campaign_id]))
    value_cast = Arel::Nodes::NamedFunction.new("CAST", [value.as("bigint[]")])
    where Arel::Nodes::InfixOperation.new("@>", arel_table[:assigned_fallback_campaign_ids], value_cast)
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
  has_paper_trail on: %i[update], only: %i[
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

  def active?
    status == ENUMS::PROPERTY_STATUSES::ACTIVE
  end

  def pending?
    status == ENUMS::PROPERTY_STATUSES::PENDING
  end

  def hide_on_responsive?
    responsive_behavior == ENUMS::PROPERTY_RESPONSIVE_BEHAVIORS::HIDE
  end

  def show_footer_on_responsive?
    responsive_behavior == ENUMS::PROPERTY_RESPONSIVE_BEHAVIORS::FOOTER
  end

  def assigner_campaigns
    Campaign.with_assigned_property_id id
  end

  def assigned_fallback_campaigns
    return Campaign.none if assigned_fallback_campaign_ids.blank?
    Campaign.where id: assigned_fallback_campaign_ids
  end

  def favicon_image_url
    domain = url.gsub(/^https?:\/\//, "")
    "//www.google.com/s2/favicons?domain=#{domain}"
  end

  def pretty_url
    url.gsub(/^https?:\/\//, "").gsub("www.", "").split("/").first
  end

  def matching_campaigns
    Campaign.targeted_premium_for_property self
  end

  # Returns a relation for campaigns that have been rendered on this property
  # NOTE: Expects scoped daily_summaries to be pre-built by EnsureScopedDailySummariesJob
  def displayed_campaigns(start_date = nil, end_date = nil)
    subquery = daily_summaries.displayed.where(scoped_by_type: "Campaign")
    subquery = subquery.between(start_date, end_date) if start_date
    Campaign.where id: subquery.distinct.pluck(:scoped_by_id).map(&:to_i)
  end

  def update_audience
    update_columns audience: Audience.match(keywords).name
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
  private

  def generate_screenshot
    GeneratePropertyScreenshotJob.perform_later(id) if saved_change_to_url?
  end

  def sanitize_assigned_fallback_campaign_ids
    self.assigned_fallback_campaign_ids = assigned_fallback_campaign_ids.select(&:present?).uniq.sort
  end

  def status_changed_to_active_on_preceding_save?
    return false unless active?
    status_previously_changed? && status_previous_change.last == ENUMS::PROPERTY_STATUSES::ACTIVE
  end

  def destroy_paper_trail_versions
    PaperTrail::Version.where(id: versions.select(:id)).delete_all
  end

  def assign_audience(force: false)
    self.audience = nil if force
    self.audience ||= Audience.match(keywords).name
  end
end
