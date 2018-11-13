# frozen_string_literal: true

class CampaignSearch < ApplicationSearchRecord
  FIELDS = %w[
    keywords
    negative_keywords
    countries
    name
    statuses
    us_hours_only
    user
    weekdays_only
  ].freeze

  def initialize(attrs = {})
    super FIELDS, attrs
    self.us_hours_only = boolean(us_hours_only)
    self.weekdays_only = boolean(weekdays_only)
    (self.keywords ||= []).reject!(&:blank?)
    (self.negative_keywords ||= []).reject!(&:blank?)
    (self.countries ||= []).reject!(&:blank?)
    (self.statuses ||= []).reject!(&:blank?)
  end

  def apply(relation)
    return relation unless present?

    relation
      .then { |result| result.search_keywords(*keywords) }
      .then { |result| result.search_negative_keywords(*negative_keywords) }
      .then { |result| result.search_countries(*countries) }
      .then { |result| result.search_name(name) }
      .then { |result| result.search_status(*statuses) }
      .then { |result| us_hours_only ? result.search_us_hours_only(us_hours_only) : result }
      .then { |result| result.search_user(user) }
      .then { |result| weekdays_only ? result.search_weekdays_only(weekdays_only) : result }
  end
end
