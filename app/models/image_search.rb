# frozen_string_literal: true

class ImageSearch < ApplicationSearchRecord
  FIELDS = %w[
    formats
    name
    description
  ].freeze

  def initialize(attrs = {})
    super FIELDS, attrs
    (self.formats ||= []).reject!(&:blank?)
  end

  def apply(relation)
    return relation unless present?
    relation
      .then { |result| result.search_metadata_format *formats }
      .then { |result| result.search_metadata_name name }
      .then { |result| result.search_metadata_description description }
  end
end
