# frozen_string_literal: true

class UserSearch < ApplicationSearchRecord
  def initialize(attrs = {})
    super %w[name email company roles], attrs
    roles.reject!(&:blank?)
  end

  def name
    @attributes[:name]
  end

  def email
    @attributes[:email]
  end

  def company
    @attributes[:company]
  end

  def roles
    @attributes[:roles] || []
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
