# == Schema Information
#
# Table name: properties
#
#  id                             :bigint           not null, primary key
#  ad_template                    :string
#  ad_theme                       :string
#  assigned_fallback_campaign_ids :bigint           default([]), not null, is an Array
#  deleted_at                     :datetime
#  description                    :text
#  fallback_ad_template           :string
#  fallback_ad_theme              :string
#  keywords                       :string           default([]), not null, is an Array
#  language                       :string           not null
#  name                           :string           not null
#  prohibit_fallback_campaigns    :boolean          default(FALSE), not null
#  prohibited_advertiser_ids      :bigint           default([]), not null, is an Array
#  prohibited_organization_ids    :bigint           default([]), not null, is an Array
#  property_type                  :string           default("website"), not null
#  responsive_behavior            :string           default("none"), not null
#  restrict_to_assigner_campaigns :boolean          default(FALSE), not null
#  revenue_percentage             :decimal(, )      default(0.6), not null
#  status                         :string           not null
#  url                            :text             not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  audience_id                    :bigint
#  legacy_id                      :uuid
#  user_id                        :bigint           not null
#
# Indexes
#
#  index_properties_on_assigned_fallback_campaign_ids  (assigned_fallback_campaign_ids) USING gin
#  index_properties_on_audience_id                     (audience_id)
#  index_properties_on_keywords                        (keywords) USING gin
#  index_properties_on_name                            (lower((name)::text))
#  index_properties_on_prohibited_advertiser_ids       (prohibited_advertiser_ids) USING gin
#  index_properties_on_prohibited_organization_ids     (prohibited_organization_ids) USING gin
#  index_properties_on_property_type                   (property_type)
#  index_properties_on_status                          (status)
#  index_properties_on_user_id                         (user_id)
#

class Property < ApplicationRecord
  # extends ...................................................................

  # includes ..................................................................
  include Properties::Chartable
  include Properties::Impressionable
  include Properties::Presentable
  include Properties::Reportable
  include Eventable
  include Imageable
  include Impressionable
  include Keywordable
  include Sparklineable
  include Taggable

  # relationships .............................................................
  belongs_to :user
  belongs_to :audience, optional: true
  has_many :property_advertisers, dependent: :destroy
  has_many :advertisers, through: :property_advertisers, class_name: "User", foreign_key: "advertiser_id"
  has_many :property_traffic_estimates, dependent: :destroy

  # validations ...............................................................
  # validates :ad_template, presence: true
  # validates :ad_theme, presence: true
  validates :language, length: {maximum: 255}, allow_blank: false
  validates :name, length: {maximum: 255}, allow_blank: false
  validates :property_type, inclusion: {in: ENUMS::PROPERTY_TYPES.values}
  validates :responsive_behavior, inclusion: {in: ENUMS::PROPERTY_RESPONSIVE_BEHAVIORS.values}
  validates :revenue_percentage, numericality: {less_than_or_equal_to: 1.0, greater_than_or_equal_to: 0}
  validates :status, inclusion: {in: ENUMS::PROPERTY_STATUSES.values}
  validates :url, url: true

  # callbacks .................................................................
  before_validation :assign_audience
  before_save :assign_restrict_to_assigner_campaigns
  before_save :sanitize_assigned_fallback_campaign_ids
  after_save :generate_screenshot
  before_destroy :destroy_paper_trail_versions
  before_destroy :validate_destroyable

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
    relation = relation.without_all_prohibited_organization_ids(campaign.id)
    relation
  }
  scope :with_assigned_fallback_campaign_id, ->(campaign_id) {
    value = Arel::Nodes::SqlLiteral.new(sanitize_sql_array(["ARRAY[?]", campaign_id]))
    value_cast = Arel::Nodes::NamedFunction.new("CAST", [value.as("bigint[]")])
    where Arel::Nodes::InfixOperation.new("@>", arel_table[:assigned_fallback_campaign_ids], value_cast)
  }
  scope :order_by_status, -> {
                            order_by = ["CASE"]
                            ENUMS::PROPERTY_STATUSES.values.each_with_index do |status, index|
                              order_by << "WHEN status='#{status}' THEN #{index}"
                            end
                            order_by << "END"
                            order(Arel.sql(order_by.join(" ")))
                          }

  # Scopes and helpers provied by tag_columns
  # SEE: https://github.com/hopsoft/tag_columns
  #
  # - with_all_prohibited_organization_ids
  # - with_any_prohibited_organization_ids
  # - with_prohibited_organization_ids
  # - without_all_prohibited_organization_ids
  # - without_any_prohibited_organization_ids
  # - without_prohibited_organization_ids
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
  tag_columns :prohibited_organization_ids
  # DEPRECATE: Remove this after dropping `prohibited_advertiser_ids` column
  tag_columns :prohibited_advertiser_ids
  tag_columns :keywords
  has_one_attached :screenshot
  # DEPRECATE: Remove `prohibited_advertiser_ids` when column is dropped
  has_paper_trail on: %i[update], only: %i[
    ad_template
    ad_theme
    keywords
    language
    prohibit_fallback_campaigns
    prohibited_organization_ids
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

  attr_accessor :temporary_id

  def to_stashable_attributes
    as_json.merge temporary_id: temporary_id
  end

  def host
    URI.parse(url).host
  end

  def restrict_to_sponsor_campaigns?
    host == "github.com"
  end

  def active?
    status == ENUMS::PROPERTY_STATUSES::ACTIVE
  end

  def archived?
    status == ENUMS::PROPERTY_STATUSES::ARCHIVED
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

  def sponsor_campaigns
    assigner_campaigns.sponsor
  end

  def current_sponsor_campaign
    return nil unless restrict_to_sponsor_campaigns?
    sponsor_campaigns.premium.available_on(Date.current).first ||
      Campaign.sponsor.fallback_with_assigned_property_id(id).available_on(Date.current).first ||
      Campaign.sponsor.fallback.permitted_for_property_id(id).available_on(Date.current).first
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
    update_columns audience_id: Audience.match(keywords)&.id
  end

  def assign_keywords(force_audience_keywords: false)
    return unless audience

    original_keywords = keywords
    audience_keywords = audience.keywords
    force_audience_keywords ||= audience_id_changed? || original_keywords.blank?

    self.keywords = if force_audience_keywords
      audience_keywords
    else
      (original_keywords & audience_keywords).uniq.sort
    end
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
    self.audience ||= Audience.match(keywords)
    assign_keywords
    audience
  end

  def assign_restrict_to_assigner_campaigns
    self.restrict_to_assigner_campaigns ||= restrict_to_sponsor_campaigns?
  end

  def validate_destroyable
    return unless DailySummary.find_by(scoped_by_type: "Property", scoped_by_id: id)
    errors.add :base, "Record has associated daily summaries, try archiving it instead."
    throw :abort
  end
end
