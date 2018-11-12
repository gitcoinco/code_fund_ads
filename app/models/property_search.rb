# frozen_string_literal: true

class PropertySearch < ApplicationSearchRecord
  FIELDS = %w[
    languages
    name
    keywords
    property_types
    statuses
    templates
    topic_categories
    user
  ].freeze

  def initialize(attrs = {})
    super FIELDS, attrs
    self.languages = (languages || []).reject(&:blank?)
    self.keywords = (keywords || []).reject(&:blank?)
    self.property_types = (property_types || []).reject(&:blank?)
    self.statuses = (statuses || []).reject(&:blank?)
    self.templates = (templates || []).reject(&:blank?)
    self.topic_categories = (topic_categories || []).reject(&:blank?)
  end

  def apply(relation)
    return relation unless present?
    relation
      .then { |result| result.search_languages(*languages) }
      .then { |result| result.search_name(name) }
      .then { |result| result.search_keywords(*keywords) }
      .then { |result| result.search_property_type(*property_types) }
      .then { |result| result.search_status(*statuses) }
      .then { |result| result.search_template(*templates) }
      .then { |result| result.search_user(user) }
  end
end
