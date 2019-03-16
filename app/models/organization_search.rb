class OrganizationSearch < ApplicationSearchRecord
  FIELDS = %w[
    name
    balance_direction
  ].freeze

  def initialize(attrs = {})
    super FIELDS, attrs
  end

  def apply(relation)
    return relation unless present?
    relation
      .then { |result| result.search_name(name) }
      .then { |result| result.search_balance_direction(balance_direction) }
  end
end
