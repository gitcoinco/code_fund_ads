# frozen_string_literal: true

class PropertySearch < ApplicationSearchRecord
  FIELDS = %w[
    ad_templates
    keywords
    languages
    name
    property_types
    statuses
    user
  ].freeze

  def initialize(attrs = {})
    super FIELDS, attrs
    (self.ad_templates ||= []).reject!(&:blank?)
    (self.keywords ||= []).reject!(&:blank?)
    (self.languages ||= []).reject!(&:blank?)
    (self.property_types ||= []).reject!(&:blank?)
    (self.statuses ||= []).reject!(&:blank?)
  end

  def apply(relation)
    return relation unless present?
    relation
      .then { |result| result.search_ad_template(*ad_templates) }
      .then { |result| result.search_keywords(*keywords) }
      .then { |result| result.search_language(*languages) }
      .then { |result| result.search_name(name) }
      .then { |result| result.search_property_type(*property_types) }
      .then { |result| result.search_status(*statuses) }
      .then { |result| result.search_user(user) }
  end
end
