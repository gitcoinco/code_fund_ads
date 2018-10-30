# frozen_string_literal: true

class UserSearch < ApplicationSearchRecord
  attr_reader :model
  delegate :all, to: :model

  def initialize(attrs = {})
    @model = User
    @attributes = attrs.try(:to_unsafe_hash) || attrs || {}
    @attributes.keep_if do |key, value|
      %w[name email company roles].include?(key.to_s) && value.present?
    end

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
