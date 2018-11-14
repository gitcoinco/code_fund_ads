# frozen_string_literal: true

class ImageSearch < ApplicationSearchRecord
  FIELDS = %w[
    description
    filename
    formats
    name
  ].freeze

  def initialize(attrs = {})
    super FIELDS, attrs
    (self.formats ||= []).reject!(&:blank?)
  end

  def apply(relation)
    return relation unless present?
    relation
      .then { |result| result.merge ActiveStorage::Attachment.search_filename(filename).merge result }
      .then { |result| result.merge ActiveStorage::Attachment.search_metadata_description(description) }
      .then { |result| result.merge ActiveStorage::Attachment.search_metadata_format(*formats) }
      .then { |result| result.merge ActiveStorage::Attachment.search_metadata_name(name) }
  end
end
