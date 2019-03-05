class ApplicantSearch < ApplicationSearchRecord
  FIELDS = %w[
    roles
    statuses
    email
    first_name
    last_name
  ].freeze

  def initialize(attrs = {})
    super FIELDS, attrs
    (self.roles ||= []).reject!(&:blank?)
    (self.statuses ||= []).reject!(&:blank?)
  end

  def apply(relation)
    return relation unless present?
    relation
      .then { |result| result.search_roles(*roles) }
      .then { |result| result.search_status(*statuses) }
      .then { |result| result.search_email(email) }
      .then { |result| result.search_first_name(first_name) }
      .then { |result| result.search_last_name(last_name) }
  end
end
