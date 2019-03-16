class CreativeSearch < ApplicationSearchRecord
  FIELDS = %w[
    name
    user_id
    user
  ].freeze

  def initialize(attrs = {})
    super FIELDS, attrs
  end

  def apply(relation)
    return relation unless present?

    relation
      .then { |result| result.search_name(name) }
      .then { |result| result.search_user(user) }
      .then { |result| result.search_user_id(user_id) }
  end
end
