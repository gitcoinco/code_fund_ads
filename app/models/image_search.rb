class ImageSearch < ApplicationSearchRecord
  FIELDS = %w[
    user_id
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
    search_relation = relation.model.all.
      then { |result| result.search_user_id(user_id) }.
      then { |result| result.search_filename(filename) }.
      then { |result| result.search_metadata_description(description) }.
      then { |result| result.search_metadata_format(*formats) }.
      then { |result| result.search_metadata_name(name) }
    relation.merge search_relation
  end
end
