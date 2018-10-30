# frozen_string_literal: true

class UserSearch < ApplicationSearchRecord
  FIELDS = %w[
    company
    email
    name
    roles
  ].freeze

  def initialize(attrs = {})
    super FIELDS, attrs
    self.roles = (roles || []).reject(&:blank?)
  end

  def apply(relation)
    return relation unless present?
    relation
      .then { |result| result.search_name(name) }
      .then { |result| result.search_email(email) }
      .then { |result| result.search_company(company) }
      .then { |result| result.search_roles(*roles) }
  end
end
