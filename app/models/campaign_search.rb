class CampaignSearch < ApplicationSearchRecord
  FIELDS = %w[
    core_hours_only
    country_codes
    keywords
    name
    negative_keywords
    province_codes
    statuses
    user
    user_id
    weekdays_only
  ].freeze

  def initialize(attrs = {})
    super FIELDS, attrs
    self.core_hours_only = boolean(core_hours_only)
    self.weekdays_only = boolean(weekdays_only)
    (self.keywords ||= []).reject!(&:blank?)
    (self.negative_keywords ||= []).reject!(&:blank?)
    (self.country_codes ||= []).reject!(&:blank?)
    (self.province_codes ||= []).reject!(&:blank?)
    (self.statuses ||= []).reject!(&:blank?)
  end

  def apply(relation)
    return relation unless present?

    relation.
      then { |result| result.search_keywords(*keywords) }.
      then { |result| result.search_negative_keywords(*negative_keywords) }.
      then { |result| result.search_country_codes(*country_codes) }.
      then { |result| result.search_province_codes(*province_codes) }.
      then { |result| result.search_name(name) }.
      then { |result| result.search_status(*statuses) }.
      then { |result| core_hours_only ? result.search_core_hours_only(core_hours_only) : result }.
      then { |result| result.search_user(user) }.
      then { |result| result.search_user_id(user_id) }.
      then { |result| weekdays_only ? result.search_weekdays_only(weekdays_only) : result }
  end
end
