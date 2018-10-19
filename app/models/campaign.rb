# == Schema Information
#
# Table name: campaigns
#
#  id                             :uuid             not null, primary key
#  name                           :string(255)      not null
#  redirect_url                   :text             not null
#  status                         :integer          default(0), not null
#  ecpm                           :decimal(10, 2)   not null
#  budget_daily_amount            :decimal(10, 2)   not null
#  total_spend                    :decimal(10, 2)   not null
#  user_id                        :uuid
#  inserted_at                    :datetime         not null
#  updated_at                     :datetime         not null
#  audience_id                    :uuid
#  creative_id                    :uuid
#  included_countries             :string(255)      default([]), is an Array
#  impression_count               :integer          default(0), not null
#  start_date                     :datetime
#  end_date                       :datetime
#  us_hours_only                  :boolean          default(FALSE)
#  weekdays_only                  :boolean          default(FALSE)
#  included_programming_languages :string(255)      default([]), is an Array
#  included_topic_categories      :string(255)      default([]), is an Array
#  excluded_programming_languages :string(255)      default([]), is an Array
#  excluded_topic_categories      :string(255)      default([]), is an Array
#  fallback_campaign              :boolean          default(FALSE), not null
#

class Campaign < ApplicationRecord
  STATUSES = {
    pending: 1,
    active: 2,
    archived: 3
  }.freeze

  # extends ...................................................................
  # includes ..................................................................
  include TagColumns

  # relationships .............................................................
  belongs_to :creative
  belongs_to :user
  has_many :impressions

  # validations ...............................................................
  validates :budget_daily_amount, numericality: { greater_than_or_equal_to: 0, allow_nil: false }
  validates :ecpm, numericality: { greater_than_or_equal_to: 0, allow_nil: false }
  validates :fallback_campaign, presence: true
  validates :impression_count, numericality: { greater_than_or_equal_to: 0, allow_nil: false }
  validates :name, length: { maximum: 255, allow_blank: false }
  validates :redirect_url, presence: true
  validates :status, inclusion: { in: STATUSES.values }
  validates :total_spend, numericality: { greater_than_or_equal_to: 0, allow_nil: false }

  # callbacks .................................................................

  # scopes ....................................................................

  # Scopes and helpers provied by tag_columns
  # SEE: https://github.com/hopsoft/tag_columns
  #
  # - with_included_countries
  # - without_included_countries
  # - with_any_included_countries
  # - without_any_included_countries
  # - with_all_included_countries
  # - without_all_included_countries
  #
  # - with_included_topic_categories
  # - without_included_topic_categories
  # - with_any_included_topic_categories
  # - without_any_included_topic_categories
  # - with_all_included_topic_categories
  # - without_all_included_topic_categories
  #
  # - with_included_programming_languages
  # - without_included_programming_languages
  # - with_any_included_programming_languages
  # - without_any_included_programming_languages
  # - with_all_included_programming_languages
  # - without_all_included_programming_languages
  #
  # - with_excluded_topic_categories
  # - without_excluded_topic_categories
  # - with_any_excluded_topic_categories
  # - without_any_excluded_topic_categories
  # - with_all_excluded_topic_categories
  # - without_all_excluded_topic_categories
  #
  # - with_excluded_programming_languages
  # - without_excluded_programming_languages
  # - with_any_excluded_programming_languages
  # - without_any_excluded_programming_languages
  # - with_all_excluded_programming_languages
  # - without_all_excluded_programming_languages
  #
  # Examples
  #
  #   irb>Campaign.with_included_countries(:US, :GB)
  #   irb>Campaign.without_included_topic_categories("Frontend Frameworks & Tools")
  #   irb>Campaign.with_included_programming_languages(:ruby, :javascript)
  #   irb>Campaign.without_excluded_topic_categories("Database", "Docker", "React")
  #   irb>Campaign.with_any_excluded_programming_languages(:perl, :prolog)

  scope :pending, -> { where status: STATUSES[:pending] }
  scope :active, -> { where status: STATUSES[:active] }
  scope :archived, -> { where status: STATUSES[:archived] }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............
  tag_columns :included_countries
  tag_columns :included_topic_categories
  tag_columns :included_programming_languages
  tag_columns :excluded_topic_categories
  tag_columns :excluded_programming_languages

  # class methods .............................................................
  class << self
  end

  # public instance methods ...................................................

  # protected instance methods ................................................
  protected

  # private instance methods ..................................................
  private
end
