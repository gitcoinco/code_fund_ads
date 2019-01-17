# == Schema Information
#
# Table name: campaigns
#
#  id                    :bigint(8)        not null, primary key
#  user_id               :bigint(8)
#  creative_id           :bigint(8)
#  status                :string           not null
#  fallback              :boolean          default(FALSE), not null
#  name                  :string           not null
#  url                   :text             not null
#  start_date            :date
#  end_date              :date
#  core_hours_only       :boolean          default(FALSE)
#  weekdays_only         :boolean          default(FALSE)
#  total_budget_cents    :integer          default(0), not null
#  total_budget_currency :string           default("USD"), not null
#  daily_budget_cents    :integer          default(0), not null
#  daily_budget_currency :string           default("USD"), not null
#  ecpm_cents            :integer          default(0), not null
#  ecpm_currency         :string           default("USD"), not null
#  countries             :string           default([]), is an Array
#  keywords              :string           default([]), is an Array
#  negative_keywords     :string           default([]), is an Array
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  legacy_id             :uuid
#  organization_id       :bigint(8)
#

class Campaign < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include Campaigns::Budgetable
  include Campaigns::Impressionable
  include Campaigns::Operable
  include Campaigns::Predictable
  include Campaigns::Presentable
  include Campaigns::Recommendable
  include Campaigns::Versionable
  include Eventable
  include Impressionable
  include Organizationable
  include Sparklineable
  include Taggable

  # relationships .............................................................
  belongs_to :creative, optional: true
  belongs_to :user

  # validations ...............................................................
  validates :name, length: {maximum: 255, allow_blank: false}
  validates :url, presence: true
  validates :status, inclusion: {in: ENUMS::CAMPAIGN_STATUSES.values}

  # callbacks .................................................................
  before_validation :sort_arrays

  # scopes ....................................................................
  scope :pending, -> { where status: ENUMS::CAMPAIGN_STATUSES::PENDING }
  scope :active, -> { where status: ENUMS::CAMPAIGN_STATUSES::ACTIVE }
  scope :archived, -> { where status: ENUMS::CAMPAIGN_STATUSES::ARCHIVED }
  scope :fallback, -> { where fallback: true }
  scope :premium, -> { where fallback: false }
  scope :available_on, ->(date) { where(arel_table[:start_date].lteq(date.to_date)).where(arel_table[:end_date].gteq(date.to_date)) }
  scope :search_keywords, ->(*values) { values.blank? ? all : with_any_keywords(*values) }
  scope :search_countries, ->(*values) { values.blank? ? all : with_any_countries(*values) }
  scope :search_name, ->(value) { value.blank? ? all : search_column(:name, value) }
  scope :search_negative_keywords, ->(*values) { values.blank? ? all : with_any_negative(*values) }
  scope :search_status, ->(*values) { values.blank? ? all : where(status: values) }
  scope :search_core_hours_only, ->(value) { value.nil? ? all : where(core_hours_only: value) }
  scope :search_user, ->(value) { value.blank? ? all : where(user_id: User.advertisers.search_name(value).or(User.advertisers.search_company(value))) }
  scope :search_user_id, ->(value) { value.blank? ? all : where(user_id: value) }
  scope :search_weekdays_only, ->(value) { value.nil? ? all : where(weekdays_only: value) }
  scope :permitted_for_property_id, ->(property_id) {
    subquery = Property.select(:prohibited_advertiser_ids).where(id: property_id)
    id_prohibited = Arel::Nodes::InfixOperation.new("<@", Arel::Nodes::SqlLiteral.new("ARRAY[\"campaigns\".\"user_id\"]"), subquery.arel)
    where.not id_prohibited
  }
  scope :targeted_premium_for_property, ->(property, *keywords) { targeted_premium_for_property_id property.id }
  scope :targeted_premium_for_property_id, ->(property_id, *keywords) { premium.targeted_for_property_id(property_id, *keywords) }
  scope :targeted_for_property_id, ->(property_id, *keywords) do
    if keywords.present?
      permitted_for_property_id(property_id).
        with_any_keywords(*keywords).
        without_any_negative_keywords(*keywords)
    else
      subquery = Property.active.select(:keywords).where(id: property_id)
      keywords_overlap = Arel::Nodes::InfixOperation.new("&&", arel_table[:keywords], subquery.arel)
      negative_keywords_overlap = Arel::Nodes::InfixOperation.new("&&", arel_table[:negative_keywords], subquery.arel)
      permitted_for_property_id(property_id).
        where(keywords_overlap).
        where.not(negative_keywords_overlap)
    end
  end
  scope :fallback_for_property_id, ->(property_id) do
    permitted_for_property_id(property_id).
      where(fallback: true).
      where.not(fallback: Property.select(:prohibit_fallback_campaigns).where(id: property_id).limit(1))
  end
  scope :targeted_fallback_for_property_id, ->(property_id, *keywords) do
    targeted_for_property_id(property_id, *keywords).
      where(fallback: true).
      where.not(fallback: Property.select(:prohibit_fallback_campaigns).where(id: property_id).limit(1))
  end

  # Scopes and helpers provied by tag_columns
  # SEE: https://github.com/hopsoft/tag_columns
  #
  # - with_countries
  # - without_countries
  # - with_any_countries
  # - without_any_countries
  # - with_all_countries
  # - without_all_countries
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
  #   irb>Campaign.with_countries("US", "GB")
  #   irb>Campaign.with_keywords("Frontend Frameworks & Tools", "Ruby")
  #   irb>Campaign.without_negative_keywords("Database", "Docker", "React")

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  monetize :total_budget_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :daily_budget_cents, numericality: {greater_than_or_equal_to: 0}
  monetize :ecpm_cents, numericality: {greater_than_or_equal_to: 0}
  tag_columns :countries
  tag_columns :keywords
  tag_columns :negative_keywords
  acts_as_commentable
  has_paper_trail on: %i[create update destroy], version_limit: nil, only: %i[
    countries
    creative_id
    daily_budget_cents
    daily_budget_currency
    ecpm_cents
    ecpm_currency
    end_date
    keywords
    name
    negative_keywords
    start_date
    status
    total_budget_cents
    total_budget_currency
    url
    core_hours_only
    user_id
    weekdays_only
  ]

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  def impressions
    Impression.partitioned(user_id, start_date.advance(months: -3), end_date.advance(months: 3)).where(campaign: self)
  end

  # Returns a relation for properties that have rendered this campaign
  def properties(start_date = nil, end_date = nil)
    subquery = impressions.between(start_date, end_date).distinct(:property_id).select(:property_id) if start_date
    subquery ||= impressions.distinct(:property_id).select(:property_id)
    Property.where id: subquery
  end

  # Returns a relation for properties that have produced a click for this campaign
  def properties_with_clicks(start_date = nil, end_date = nil)
    subquery = impressions.clicked.between(start_date, end_date).distinct(:property_id).select(:property_id) if start_date
    subquery ||= impressions.clicked.distinct(:property_id).select(:property_id)
    Property.where id: subquery
  end

  def matching_properties
    Property.for_campaign self
  end

  def matching_keywords(property)
    keywords & property.keywords
  end

  def pending?
    ENUMS::CAMPAIGN_STATUSES.pending? status
  end

  def active?
    ENUMS::CAMPAIGN_STATUSES.active? status
  end

  def archived?
    ENUMS::CAMPAIGN_STATUSES.archived? status
  end

  def available_on?(date)
    date.to_date.between? start_date, end_date
  end

  def date_range
    return nil unless start_date && end_date
    "#{start_date.to_s "mm/dd/yyyy"} #{end_date.to_s "mm/dd/yyyy"}"
  end

  def date_range=(value)
    dates = value.split(" - ")
    self.start_date = Date.strptime(dates[0], "%m/%d/%Y")
    self.end_date   = Date.strptime(dates[1], "%m/%d/%Y")
  end

  def campaign_type
    return "fallback" if fallback?
    "premium"
  end

  # protected instance methods ................................................

  # private instance methods ..................................................

  private

  def sort_arrays
    self.countries = countries&.sort || []
    self.keywords = keywords&.sort || []
    self.negative_keywords = negative_keywords&.sort || []
  end
end
