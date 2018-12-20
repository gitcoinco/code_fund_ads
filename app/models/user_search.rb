class UserSearch < ApplicationSearchRecord
  FIELDS = %w[
    organization_id
    email
    name
    roles
  ].freeze

  def initialize(attrs = {})
    super FIELDS, attrs
    (self.roles ||= []).reject!(&:blank?)
  end

  def apply(relation)
    return relation unless present?
    relation.
      then { |result| result.search_organization(organization_id) }.
      then { |result| result.search_email(email) }.
      then { |result| result.search_name(name) }.
      then { |result| result.search_roles(*roles) }
  end
end
