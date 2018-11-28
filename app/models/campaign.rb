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
#  us_hours_only         :boolean          default(FALSE)
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
#

class Campaign < ApplicationRecord
  TOTAL_IMPRESSIONS_COUNT_KEY = "total_impressions_count".freeze
  DAILY_IMPRESSIONS_COUNT_KEY = "daily_impressions_count".freeze

  # extends ...................................................................
  # includes ..................................................................
  include Taggable
  include Campaigns::Presentable

  # relationships .............................................................
  belongs_to :creative
  belongs_to :user
  has_one :total_impressions_counter, -> { where scope: TOTAL_IMPRESSIONS_COUNT_KEY }, as: :record, class_name: "Counter"
  has_many :impressions
  has_many :daily_impressions_counters, -> { where scope: DAILY_IMPRESSIONS_COUNT_KEY }, as: :record, class_name: "Counter"

  # validations ...............................................................
  validates :name, length: {maximum: 255, allow_blank: false}
  validates :url, presence: true
  validates :status, inclusion: {in: ENUMS::CAMPAIGN_STATUSES.values}

  # callbacks .................................................................

  # scopes ....................................................................
  scope :pending, -> { where status: ENUMS::CAMPAIGN_STATUSES::PENDING }
  scope :active, -> { where status: ENUMS::CAMPAIGN_STATUSES::ACTIVE }
  scope :archived, -> { where status: ENUMS::CAMPAIGN_STATUSES::ARCHIVED }
  scope :available_on, ->(date) { where(arel_table[:start_date].lteq(date)).where(arel_table[:end_date].gteq(date)) }
  scope :available, -> { available_on Date.current }
  scope :search_keywords, ->(*values) { values.blank? ? all : with_any_keywords(*values) }
  scope :search_countries, ->(*values) { values.blank? ? all : with_any_countries(*values) }
  scope :search_name, ->(value) { value.blank? ? all : search_column(:name, value) }
  scope :search_negative_keywords, ->(*values) { values.blank? ? all : with_any_negative(*values) }
  scope :search_status, ->(*values) { values.blank? ? all : where(status: values) }
  scope :search_us_hours_only, ->(value) { value.nil? ? all : where(us_hours_only: value) }
  scope :search_user, ->(value) { value.blank? ? all : where(user_id: User.advertiser.search_name(value).or(User.advertiser.search_company(value))) }
  scope :search_user_id, ->(value) { value.blank? ? all : where(user_id: value) }
  scope :search_weekdays_only, ->(value) { value.nil? ? all : where(weekdays_only: value) }
  scope :for_property, ->(property) do
    relation = with_any_keywords(*property.keywords).without_any_negative_keywords(*property.keywords)
    relation = relation.where(fallback: false) if property.prohibit_fallback_campaigns
    relation
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

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................
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

  def total_impressions_count_cache_key
    "#{cache_key}/#{TOTAL_IMPRESSIONS_COUNT_KEY}"
  end

  def daily_impressions_count_cache_key(date = nil)
    "#{cache_key}/#{DAILY_IMPRESSIONS_COUNT_KEY}/#{(date || Date.current).to_date.iso8601}"
  end

  def total_impressions_count
    Rails.cache.fetch total_impressions_count_cache_key, expires_in: (remaining_operative_days + 7).days do
      counter = total_impressions_counter
      InitializeTotalImpressionsCountJob.perform_later id unless counter
      counter&.count.to_i
    end
  end

  def daily_impressions_count(date = nil)
    date ||= Date.current
    Rails.cache.fetch daily_impressions_count_cache_key(date), expires_in: 2.days do
      counter = daily_impressions_counters.segmented_by(date.iso8601).first
      InitializeDailyImpressionsCountJob.perform_later id, date.iso8601 unless counter
      counter&.count.to_i
    end
  end

  def scoped_name
    [user.scoped_name, name, creative&.name].compact.join "・"
  end

  def date_range
    return nil unless start_date && end_date
    "#{start_date.to_s "mm/dd/yyyy"} #{end_date.to_s "mm/dd/yyyy"}"
  end

  def recommended_daily_budget
    total_remaining_budget / remaining_operative_days
  end

  def recommended_end_date
    total_available_impression_count = ((total_remaining_budget.to_f / ecpm.to_f) * 1_000).ceil
    days = total_available_impression_count / estimated_max_daily_impression_count

    date = start_date
    date = Current.date if date.past?

    return date.advance(days: days) unless weekdays_only?

    count = 0
    while count < days
      count += 1 unless date.saturday? || date.sunday?
      date = date.advance(days: 1)
    end
    date
  end

  def operative_dates
    dates = (start_date..end_date).to_a
    return dates unless weekdays_only?
    dates.select { |date| !date.saturday? && !date.sunday? }
  end

  def total_operative_days
    operative_dates.size
  end

  def remaining_operative_dates
    today = Date.current
    operative_dates.select { |date| date >= today }
  end

  def remaining_operative_days
    remaining_operative_dates.size
  end

  def estimated_max_total_impression_count
    ((total_budget.to_f / ecpm.to_f) * 1_000).ceil
  end

  def estimated_max_remaining_impression_count
    estimated_max_daily_impression_count * remaining_operative_days
  end

  def estimated_max_daily_impression_count
    ((daily_budget.to_f / ecpm.to_f) * 1_000).ceil
  end

  def total_unusable_budget
    return Money.new(0, "USD") if ecpm.to_f.zero?
    total_remaining_budget - total_remaining_usable_budget
  end

  def budget_surplus?
    total_unusable_budget > 0
  end

  def total_remaining_usable_budget
    (estimated_max_remaining_impression_count / 1_000.to_f) * ecpm
  end

  def total_remaining_budget
    total_budget - total_consumed_budget
  end

  def total_consumed_budget
    ecpm * total_impressions_per_mille
  end

  def total_impressions_per_mille
    total_impressions_count / 1_000.to_f
  end

  def daily_remaining_budget
    daily_budget - daily_consumed_budget
  end

  def daily_consumed_budget
    ecpm * daily_impressions_per_mille
  end

  def daily_impressions_per_mille
    daily_impressions_count / 1_000.to_f
  end

  def date_range=(value)
    dates = value.split(" - ")
    self.start_date = Date.strptime(dates[0], "%m/%d/%Y")
    self.end_date   = Date.strptime(dates[1], "%m/%d/%Y")
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
end
