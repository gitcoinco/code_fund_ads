# frozen_string_literal: true

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
  # extends ...................................................................
  # includes ..................................................................
  include Taggable
  include Campaigns::Presentable

  # relationships .............................................................
  belongs_to :creative
  belongs_to :user
  has_many :impressions

  # validations ...............................................................
  validates :name, length: { maximum: 255, allow_blank: false }
  validates :url, presence: true
  validates :status, inclusion: { in: ENUMS::CAMPAIGN_STATUSES.values }

  # callbacks .................................................................

  # scopes ....................................................................
  scope :search_keywords, -> (*values) { values.blank? ? all : with_any_keywords(*values) }
  scope :search_countries, -> (*values) { values.blank? ? all : with_any_countries(*values) }
  scope :search_name, -> (value) { value.blank? ? all : search_column(:name, value) }
  scope :search_negative_keywords, -> (*values) { values.blank? ? all : with_any_negative(*values) }
  scope :search_status, -> (*values) { values.blank? ? all : where(status: values) }
  scope :search_us_hours_only, -> (value) { value.nil? ? all : where(us_hours_only: value) }
  scope :search_user, -> (value) { value.blank? ? all : where(user_id: User.sponsor.search_name(value).or(User.sponsor.search_company(value))) }
  scope :search_weekdays_only, -> (value) { value.nil? ? all : where(weekdays_only: value) }

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

  scope :pending, -> { where status: ENUMS::CAMPAIGN_STATUSES::PENDING }
  scope :active, -> { where status: ENUMS::CAMPAIGN_STATUSES::ACTIVE }
  scope :archived, -> { where status: ENUMS::CAMPAIGN_STATUSES::ARCHIVED }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  monetize :total_budget_cents, numericality: { greater_than_or_equal_to: 0 }
  monetize :daily_budget_cents, numericality: { greater_than_or_equal_to: 0 }
  monetize :ecpm_cents, numericality: { greater_than_or_equal_to: 0 }
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

  def date_range
    return nil unless start_date && end_date
    "#{start_date.to_s "mm/dd/yyyy"} #{end_date.to_s "mm/dd/yyyy"}"
  end

  # protected instance methods ................................................
  protected

  # private instance methods ..................................................
  private
end
