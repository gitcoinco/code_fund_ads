# frozen_string_literal: true

class PropertySearch < ApplicationSearchRecord
  FIELDS = %w[
    name
  ].freeze

  def initialize(attrs = {})
    super FIELDS, attrs
  end

  def apply(relation)
    return relation unless present?
    relation
      .then { |result| result.search_name(name) }
  end
end
