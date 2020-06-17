# == Schema Information
#
# Table name: campaigns
#
#  id                      :bigint           not null, primary key
#  assigned_property_ids   :bigint           default([]), not null, is an Array
#  audience_ids            :bigint           default([]), not null, is an Array
#  core_hours_only         :boolean          default(FALSE)
#  country_codes           :string           default([]), is an Array
#  creative_ids            :bigint           default([]), not null, is an Array
#  daily_budget_cents      :integer          default(0), not null
#  daily_budget_currency   :string           default("USD"), not null
#  ecpm_cents              :integer          default(0), not null
#  ecpm_currency           :string           default("USD"), not null
#  ecpm_multiplier         :decimal(, )      default(1.0), not null
#  end_date                :date             not null
#  fallback                :boolean          default(FALSE), not null
#  fixed_ecpm              :boolean          default(TRUE), not null
#  hourly_budget_cents     :integer          default(0), not null
#  hourly_budget_currency  :string           default("USD"), not null
#  job_posting             :boolean          default(FALSE), not null
#  keywords                :string           default([]), is an Array
#  name                    :string           not null
#  negative_keywords       :string           default([]), is an Array
#  paid_fallback           :boolean          default(FALSE)
#  prohibited_property_ids :bigint           default([]), not null, is an Array
#  province_codes          :string           default([]), is an Array
#  region_ids              :bigint           default([]), not null, is an Array
#  start_date              :date             not null
#  status                  :string           not null
#  total_budget_cents      :integer          default(0), not null
#  total_budget_currency   :string           default("USD"), not null
#  url                     :text             not null
#  weekdays_only           :boolean          default(FALSE)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  campaign_bundle_id      :bigint
#  creative_id             :bigint
#  legacy_id               :uuid
#  organization_id         :bigint
#  user_id                 :bigint
#
# Indexes
#
#  index_campaigns_on_assigned_property_ids    (assigned_property_ids) USING gin
#  index_campaigns_on_audience_ids             (audience_ids) USING gin
#  index_campaigns_on_campaign_bundle_id       (campaign_bundle_id)
#  index_campaigns_on_core_hours_only          (core_hours_only)
#  index_campaigns_on_country_codes            (country_codes) USING gin
#  index_campaigns_on_creative_id              (creative_id)
#  index_campaigns_on_creative_ids             (creative_ids) USING gin
#  index_campaigns_on_end_date                 (end_date)
#  index_campaigns_on_job_posting              (job_posting)
#  index_campaigns_on_keywords                 (keywords) USING gin
#  index_campaigns_on_name                     (lower((name)::text))
#  index_campaigns_on_negative_keywords        (negative_keywords) USING gin
#  index_campaigns_on_organization_id          (organization_id)
#  index_campaigns_on_paid_fallback            (paid_fallback)
#  index_campaigns_on_prohibited_property_ids  (prohibited_property_ids) USING gin
#  index_campaigns_on_province_codes           (province_codes) USING gin
#  index_campaigns_on_region_ids               (region_ids) USING gin
#  index_campaigns_on_start_date               (start_date)
#  index_campaigns_on_status                   (status)
#  index_campaigns_on_user_id                  (user_id)
#  index_campaigns_on_weekdays_only            (weekdays_only)
#

class Campaign < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include Campaigns::Budgetable
  include Campaigns::Impressionable
  include Campaigns::Operable
  include Campaigns::Presentable
  include Campaigns::Reportable
  include Campaigns::Statusable
  include Colorable
  include Eventable
  include Impressionable
  include Keywordable
  include Organizationable
  include Sparklineable
  include SplitTestable
  include Taggable

  # relationships .............................................................
  belongs_to :campaign_bundle, optional: true
  belongs_to :audience, optional: true
  belongs_to :region, optional: true
  belongs_to :creative, -> { includes :creative_images }, optional: true
  belongs_to :user
  has_many :pixel_conversions

  # validations ...............................................................
  validates :name, length: {maximum: 255, allow_blank: false}
  validates :url, url: true, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :validate_creatives
  validate :validate_active_creatives, if: :active?
  validate :validate_assigned_properties, if: :sponsor?

  # callbacks .................................................................
  before_validation :sync_to_campaign_bundle
  before_validation :sort_arrays
  before_validation :sanitize_creative_ids
  before_validation :assign_audiences
  before_validation :assign_regions
  before_save :sanitize_assigned_property_ids
  before_destroy :validate_destroyable
  after_save :update_campaign_bundle_dates

  # scopes ....................................................................
  # TODO: update standard/sponsor scopes to use arel instead of string interpolation
  scope :standard, -> { where "\"campaigns\".\"creative_ids\" && ARRAY(#{Creative.standard.select(:id).to_sql})" }
  scope :sponsor, -> { where "\"campaigns\".\"creative_ids\" && ARRAY(#{Creative.sponsor.select(:id).to_sql})" }
  scope :fallback, -> { where fallback: true }
  scope :paid_fallback, -> { where paid_fallback: true }
  scope :premium, -> { where(fallback: false).where(paid_fallback: false) }
  scope :job_posting, -> { where job_posting: true }
  scope :starts_on_or_before, ->(date) { where arel_table[:start_date].lteq(date.to_date) }
  scope :starts_on_or_after, ->(date) { where arel_table[:start_date].gteq(date.to_date) }
  scope :starts_after, ->(date) { where arel_table[:start_date].gt(date.to_date) }
  scope :ends_on_or_before, ->(date) { where arel_table[:end_date].lteq(date.to_date) }
  scope :ends_on_or_after, ->(date) { where arel_table[:end_date].gteq(date.to_date) }
  scope :ends_after, ->(date) { where arel_table[:end_date].gt(date.to_date) }
  scope :unending, -> { where end_date: nil }
  scope :started, -> { where arel_table[:start_date].lteq(Arel::Nodes::SqlLiteral.new("current_date")) }
  scope :ended, -> { where arel_table[:end_date].lteq(Arel::Nodes::SqlLiteral.new("current_date")) }
  scope :unended, -> { unending.or(where(arel_table[:end_date].gteq(Arel::Nodes::SqlLiteral.new("current_date")))) }
  scope :available_on, ->(date) { starts_on_or_before(date).unending.or(starts_on_or_before(date).ends_on_or_after(date)) }
  scope :search_keywords, ->(*values) { values.blank? ? all : with_any_keywords(*values) }
  scope :search_country_codes, ->(*values) { values.blank? ? all : with_any_country_codes(*values) }
  scope :search_province_codes, ->(*values) { values.blank? ? all : with_any_province_codes(*values) }
  scope :search_fallback, ->(value) { value.blank? ? all : where(fallback: value) }
  scope :search_paid_fallback, ->(value) { value.blank? ? all : where(paid_fallback: value) }
  scope :search_name, ->(value) { value.blank? ? all : search_column(:name, value) }
  scope :search_negative_keywords, ->(*values) { values.blank? ? all : with_any_negative(*values) }
  scope :search_status, ->(*values) { values.blank? ? all : where(status: values) }
  scope :search_core_hours_only, ->(value) { value.nil? ? all : where(core_hours_only: value) }
  scope :search_user, ->(value) { value.blank? ? all : where(user_id: User.advertisers.search_name(value).or(User.advertisers.search_company(value))) }
  scope :search_user_id, ->(value) { value.blank? ? all : where(user_id: value) }
  scope :search_weekdays_only, ->(value) { value.nil? ? all : where(weekdays_only: value) }
  scope :without_assigned_property_ids, -> { where assigned_property_ids: [] }
  scope :with_assigned_property_id, ->(property_id) { where "\"campaigns\".\"assigned_property_ids\" @> ?::bigint[]", "{#{property_id}}" }
  scope :with_any_assigned_property_ids, ->(*property_ids) { where "\"campaigns\".\"assigned_property_ids\" && ?::bigint[]", "{#{property_ids.select(&:present?).join(",")}}" }
  scope :premium_with_assigned_property_id, ->(property_id) { premium.with_assigned_property_id property_id }
  scope :fallback_with_assigned_property_id, ->(property_id) { fallback.with_assigned_property_id property_id }
  scope :permitted_for_property_id, ->(property_id) {
    subquery = Property.select(:prohibited_organization_ids).where(id: property_id)
    organization_id_prohibited = Arel::Nodes::InfixOperation.new("<@", Arel::Nodes::SqlLiteral.new("ARRAY[\"campaigns\".\"organization_id\"]"), subquery.arel)
    property_id_array = Arel::Nodes::SqlLiteral.new(sanitize_sql_array(["ARRAY[?::bigint]", property_id]))
    campaign_id_prohibited = Arel::Nodes::InfixOperation.new("@>", arel_table[:prohibited_property_ids], property_id_array)
    where.not(organization_id_prohibited).where.not(campaign_id_prohibited)
  }
  scope :targeted_premium_for_property, ->(property, *keywords) { targeted_premium_for_property_id property.id }
  scope :targeted_premium_for_property_id, ->(property_id, *keywords) { premium.targeted_for_property_id(property_id, *keywords) }
  scope :targeted_for_property_id, ->(property_id, *keywords) do
    if keywords.present?
      permitted_for_property_id(property_id)
        .with_any_keywords(*keywords)
        .without_any_negative_keywords(*keywords)
        .without_assigned_property_ids
    else
      subquery = Property.active.select(:keywords).where(id: property_id)
      keywords_overlap = Arel::Nodes::InfixOperation.new("&&", arel_table[:keywords], subquery.arel)
      negative_keywords_overlap = Arel::Nodes::InfixOperation.new("&&", arel_table[:negative_keywords], subquery.arel)
      permitted_for_property_id(property_id)
        .where(keywords_overlap)
        .where.not(negative_keywords_overlap)
        .without_assigned_property_ids
    end
  end
  scope :fallback_for_property_id, ->(property_id) do
    fallback
      .permitted_for_property_id(property_id)
      .where.not(fallback: Property.select(:prohibit_fallback_campaigns).where(id: property_id).limit(1))
  end
  scope :targeted_fallback_for_property_id, ->(property_id, *keywords) do
    fallback
      .targeted_for_property_id(property_id, *keywords)
      .where.not(fallback: Property.select(:prohibit_fallback_campaigns).where(id: property_id).limit(1))
  end
  scope :targeted_country_code, ->(country_code) { country_code ? with_all_country_codes(country_code) : without_country_codes }
  scope :targeted_province_code, ->(province_code) { province_code ? without_province_codes.or(with_all_province_codes(province_code)) : without_province_codes }
  scope :with_active_creatives, -> {
    where "\"campaigns\".\"creative_ids\" && (SELECT array_agg(id) FROM \"creatives\" WHERE \"creatives\".\"status\" = 'active')::bigint[]"
  }
  scope :with_inactive_creatives, -> {
    where "\"campaigns\".\"creative_ids\" && (SELECT array_agg(id) FROM \"creatives\" WHERE \"creatives\".\"status\" != 'active')::bigint[]"
  }
  scope :order_by_status, -> {
                            order_by = ["CASE"]
                            ENUMS::CAMPAIGN_STATUSES.values.each_with_index do |status, index|
                              order_by << "WHEN status='#{status}' THEN #{index}"
                            end
                            order_by << "END"
                            order(Arel.sql(order_by.join(" ")))
                          }

  # Scopes and helpers provied by tag_columns
  # SEE: https://github.com/hopsoft/tag_columns
  #
  # - with_country_codes
  # - without_country_codes
  # - with_any_country_codes
  # - without_any_country_codes
  # - with_all_country_codes
  # - without_all_country_codes
  #
  # - with_creative_ids
  # - without_creative_ids
  # - with_any_creative_ids
  # - without_any_creative_ids
  # - with_all_creative_ids
  # - without_all_creative_ids
  #
  # - with_province_codes
  # - without_province_codes
  # - with_any_province_codes
  # - without_any_province_codes
  # - with_all_province_codes
  # - without_all_province_codes
  #
  # - with_keywords
  # - without_keywords
  # - with_any_keywords
  # - without_any_keywords
  # - with_all_keywords
  # - without_all_keywords
  #
  # - with_negative_keywords
  # - without_negative_keywords
  # - with_any_negative_keywords
  # - without_any_negative_keywords
  # - with_all_negative_keywords
  # - without_all_negative_keywords
  #
  # Examples
  #
  #   irb>Campaign.with_country_codes("US", "GB")
  #   irb>Campaign.with_keywords("Frontend Frameworks & Tools", "Ruby")
  #   irb>Campaign.without_negative_keywords("Database", "Docker", "React")

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  monetize :total_budget_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :daily_budget_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :hourly_budget_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  tag_columns :creative_ids
  tag_columns :region_ids
  tag_columns :country_codes
  tag_columns :province_codes
  tag_columns :audience_ids
  tag_columns :keywords
  tag_columns :negative_keywords
  acts_as_commentable
  has_paper_trail on: %i[create update destroy], version_limit: nil, only: %i[
    core_hours_only
    country_codes
    creative_id
    daily_budget_cents
    daily_budget_currency
    ecpm_cents
    ecpm_currency
    end_date
    keywords
    name
    negative_keywords
    province_codes
    start_date
    status
    total_budget_cents
    total_budget_currency
    url
    user_id
    weekdays_only
  ]

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  attr_accessor :temporary_id

  def region_and_audience_pricing_strategy?
    pricing_strategy == ENUMS::CAMPAIGN_PRICING_STRATEGIES::REGION_AND_AUDIENCE
  end

  def campaign_pricing_strategy?
    pricing_strategy == ENUMS::CAMPAIGN_PRICING_STRATEGIES::CAMPAIGN
  end

  def pricing_strategy
    return ENUMS::CAMPAIGN_PRICING_STRATEGIES::REGION_AND_AUDIENCE if campaign_bundle
    return ENUMS::CAMPAIGN_PRICING_STRATEGIES::REGION_AND_AUDIENCE if start_date >= Date.parse("2020-06-01")
    ENUMS::CAMPAIGN_PRICING_STRATEGIES::CAMPAIGN
  end

  def to_stashable_attributes
    as_json.merge temporary_id: temporary_id
  end

  def inventory_summary
    @inventory_summary ||= InventorySummary.new(self)
  end

  def targeting_variants
    r = region_ids.present? ? regions : regions(include_fuzzy_matches: true)
    a = audience_ids.present? ? audiences : audiences(include_fuzzy_matches: true)
    r.to_a.product a.to_a
  end

  def metadata
    key = "#{cache_key_with_version}/metadata"
    Rails.cache.fetch key do
      {
        standard: standard_creatives.exists?,
        sponsor: sponsor_creatives.exists?
      }
    end
  end

  def standard?
    metadata[:standard]
  end

  def sponsor?
    metadata[:sponsor]
  end

  def creatives
    @creatives ||= Creative.where(id: creative_ids)
  end

  def permitted_creatives
    @permitted_creatives ||= Creative.where(organization_id: organization_id)
  end

  def standard_creatives
    @standard_creatives ||= creatives.standard
  end

  def sponsor_creatives
    @sponsor_creatives ||= creatives.sponsor
  end

  def split_alternative_names
    creatives.active.select(:id).map(&:split_test_name)
  end

  def assigner_properties
    return Property.none unless fallback?
    Property.with_assigned_fallback_campaign_id id
  end

  def assigned_properties
    return Property.none if assigned_property_ids.blank?
    Property.where id: assigned_property_ids
  end

  def prohibited_properties
    return Property.none if prohibited_property_ids.blank?
    Property.where id: prohibited_property_ids
  end

  def prohibit_property!(property_id)
    ids = (prohibited_property_ids.compact << property_id.to_i).uniq.sort.compact
    update(prohibited_property_ids: ids)
  end

  def prohibited_property?(property)
    property_id = property.is_a?(Property) ? property.id : property.to_i
    prohibited_property_ids.compact.include? property_id
  end

  def permit_property!(property_id)
    ids = (prohibited_property_ids.compact - [property_id.to_i]).uniq.sort.compact
    update(prohibited_property_ids: ids)
  end

  def fixed_ecpm?
    return false unless campaign_pricing_strategy?
    super
  end

  def adjusted_ecpm(country_code)
    return ecpm if fixed_ecpm?

    adjusted = ecpm * Country::UNKNOWN_CPM_MULTIPLER
    country = Country.find(country_code)
    if country
      # DEPRECATE: delete logic for country multiplier after all campaigns with a start_date before 2019-03-07 have completed
      adjusted = if start_date && start_date < Date.parse("2019-03-07")
        country.ecpm base: ecpm, multiplier: :country
      else
        country.ecpm base: ecpm
      end
    end
    adjusted = Monetize.parse("$0.10 USD") if adjusted.cents < 10
    adjusted
  end

  def ecpms
    countries.map do |country|
      {
        country_iso_code: country.iso_code,
        country_name: country.name,
        ecpm: adjusted_ecpm(country.iso_code)
      }
    end
  end

  # Returns a relation for properties that have rendered this campaign
  # NOTE: Expects scoped daily_summaries to be pre-built by EnsureScopedDailySummariesJob
  def displaying_properties(start_date = nil, end_date = nil)
    subquery = daily_summaries.displayed.where(scoped_by_type: "Property")
    subquery = subquery.between(start_date, end_date) if start_date
    Property.where id: subquery.distinct.pluck(:scoped_by_id).map(&:to_i)
  end

  def matching_properties
    @matching_properties ||= Property.for_campaign(self)
  end

  def matching_keywords(property)
    keywords & property.keywords
  end

  def premium?
    !fallback?
  end

  def available_on?(date)
    date.to_date.between? start_date, end_date
  end

  def countries
    Country.where iso_code: country_codes
  end

  def provinces
    Province.where iso_code: province_codes
  end

  def campaign_type
    return "fallback" if fallback?
    "premium"
  end

  def to_meta_tags
    {
      title: name,
      keywords: keywords
    }
  end

  def audiences(include_fuzzy_matches: false)
    relation = Audience.where(id: audience_ids)
    relation = relation.or(Audience.with_any_keywords(*keywords)) if include_fuzzy_matches
    relation
  end

  def regions(include_fuzzy_matches: false)
    relation = Region.where(id: region_ids)
    relation = relation.or(Region.with_any_country_codes(*country_codes)) if include_fuzzy_matches
    relation
  end

  def current_competitors
    return Campaign.none unless start_date
    assign_keywords
    assign_country_codes
    relation = Campaign.sold.with_any_country_codes(*country_codes).with_any_keywords(*keywords).available_on(start_date)
    relation = relation.unending.or(relation.ends_on_or_before(end_date)) if end_date
    relation
  end

  def current_premium_competitors
    return Campaign.none unless start_date
    current_competitors.premium
  end

  def future_competitors
    return Campaign.none unless start_date
    assign_keywords
    assign_country_codes
    relation = Campaign.sold.with_any_country_codes(*country_codes).with_any_keywords(*keywords).starts_after(start_date).ends_on_or_before(start_date.advance(days: 90))
    relation = relation.unending.or(relation.ends_on_or_before(end_date)) if end_date
    relation
  end

  def future_premium_competitors
    return Campaign.none unless start_date
    future_competitors.premium
  end

  def assign_keywords(force_audience_keywords: false)
    return unless audiences.exists?

    original_keywords = keywords
    audience_keywords = audiences.map(&:keywords).flatten.uniq
    force_audience_keywords ||= audience_ids_changed? || original_keywords.blank?

    self.keywords = if force_audience_keywords
      audience_keywords
    else
      (original_keywords & audience_keywords).uniq.sort
    end
  end

  def assign_country_codes(force_region_country_codes: false)
    return unless regions.exists?

    original_country_codes = country_codes
    region_country_codes = regions.map(&:country_codes).flatten.uniq
    force_region_country_codes ||= region_ids_changed? || original_country_codes.blank?

    self.country_codes = if force_region_country_codes
      region_country_codes
    else
      (original_country_codes & region_country_codes).uniq.sort
    end
  end

  def update_campaign_bundle_dates
    campaign_bundle&.update_dates
  end

  # protected instance methods ................................................

  # private instance methods ..................................................

  private

  def assign_audiences(force: false)
    self.audiences = nil if force
    self.audiences ||= Audience.match(keywords)
    assign_keywords
    audiences
  end

  def assign_regions(force: false)
    self.regions = nil if force
    self.regions ||= Region.where(id: region_ids)
    assign_country_codes
    regions
  end

  def sanitize_creative_ids
    permitted_creative_ids = permitted_creatives.distinct.pluck(:id)
    self.creative_id = ([creative_id] & permitted_creative_ids).first
    self.creative_ids = (creative_ids & permitted_creative_ids).compact.uniq
    self.creative_ids = [creative_id].compact if creative_ids.blank?
    self.creative_id = creative_ids.first unless creative_ids.include?(creative_id)
  end

  def sort_arrays
    self.audience_ids = audience_ids&.reject(&:blank?)&.sort || []
    self.region_ids = region_ids&.reject(&:blank?)&.sort || []
    self.country_codes = country_codes&.reject(&:blank?)&.sort || []
    self.keywords = keywords&.reject(&:blank?)&.sort || []
    self.negative_keywords = negative_keywords&.reject(&:blank?)&.sort || []
    self.province_codes = province_codes&.reject(&:blank?)&.sort || []
    self.creative_ids = creative_ids&.reject(&:blank?)&.sort || []
  end

  def sanitize_assigned_property_ids
    self.assigned_property_ids = assigned_property_ids.select(&:present?).uniq.sort
  end

  def validate_creatives
    if standard_creatives.exists? && sponsor_creatives.exists?
      errors.add :creatives, "cannot include both standard and sponsor types"
    end
  end

  def validate_active_creatives
    errors.add(:creatives, "must be attached") if creative_ids.blank?
    errors.add(:creatives, "cannot be inactive") if creatives.select(&:active?).blank?
  end

  def validate_assigned_properties
    return unless sponsor?
    return unless active?
    return if fallback?
    return if paid_fallback?

    conflicting_campaigns = Campaign.premium.with_any_assigned_property_ids(*assigned_property_ids).available_on(start_date)
      .or(Campaign.premium.with_any_assigned_property_ids(*assigned_property_ids).available_on(end_date))
    if conflicting_campaigns.exists?
      conflicting_campaigns.each do |conflicting_campaign|
        next if conflicting_campaign == self
        conflicting_properties = Property.where(id: assigned_property_ids & conflicting_campaign.assigned_property_ids)
        conflicting_properties.each do |conflicting_property|
          errors.add :base, "#{conflicting_property.analytics_key} is already reserved by #{conflicting_campaign.analytics_key} from #{conflicting_campaign.start_date.iso8601} through #{conflicting_campaign.start_date.iso8601}"
        end
      end
    end

    if assigned_properties.present? && assigned_properties.map(&:restrict_to_sponsor_campaigns?).uniq != [true]
      errors.add :assigned_properties, "must be set to those restricted to sponsor campaigns i.e. GitHub properties, etc..."
    end
  end

  def validate_destroyable
    return unless daily_summaries.exists? || impressions.exists?
    errors.add :base, "Record has associated impressions and/or daily summaries, try archiving it instead."
    throw :abort
  end

  def sync_to_campaign_bundle
    return unless campaign_bundle
    self.organization_id = campaign_bundle.organization_id
    self.region_ids = campaign_bundle.region_ids
    assign_country_codes
    assign_keywords
  end
end
