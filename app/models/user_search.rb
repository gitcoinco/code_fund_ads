class UserSearch < ApplicationSearchRecord
  FIELDS = %w[
    company_name
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
      then { |result| result.search_company(company_name) }.
      then { |result| result.search_email(email) }.
      then { |result| result.search_name(name) }.
      then { |result| result.search_roles(*roles) }
  end
end
