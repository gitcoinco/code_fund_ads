# frozen_string_literal: true

class CampaignSearch < ApplicationSearchRecord
  FIELDS = %w[
    excluded_programming_languages
    excluded_topic_categories
    included_countries
    included_programming_languages
    included_topic_categories
    name
    statuses
    us_hours_only
    user
    weekdays_only
  ].freeze

  def initialize(attrs = {})
    super FIELDS, attrs
    self.excluded_programming_languages = (excluded_programming_languages || []).reject(&:blank?)
    self.excluded_topic_categories = (excluded_topic_categories || []).reject(&:blank?)
    self.included_countries = (included_countries || []).reject(&:blank?)
    self.included_programming_languages = (included_programming_languages || []).reject(&:blank?)
    self.included_topic_categories = (included_topic_categories || []).reject(&:blank?)
    self.statuses = (statuses || []).reject(&:blank?)
  end

  def apply(relation)
    return relation unless present?
    relation
      .then { |result| result.search_excluded_programming_languages(*excluded_programming_languages) }
      .then { |result| result.search_excluded_topic_categories(*excluded_topic_categories) }
      .then { |result| result.search_included_countries(*included_countries) }
      .then { |result| result.search_included_programming_languages(*included_programming_languages) }
      .then { |result| result.search_included_topic_categories(*included_topic_categories) }
      .then { |result| result.search_name(name) }
      .then { |result| result.search_status(*statuses) }
      .then { |result| result.search_us_hours_only(us_hours_only) }
      .then { |result| result.search_user(user) }
      .then { |result| result.search_weekdays_only(weekdays_only) }
  end
end
