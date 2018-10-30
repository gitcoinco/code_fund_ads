# frozen_string_literal: true

class CampaignSearch < ApplicationSearchRecord
  FIELDS = %w[
    name
    statuses
    user
  ].freeze

  def initialize(attrs = {})
    super FIELDS, attrs
    self.statuses = (statuses || []).reject(&:blank?)
  end

  def apply(relation)
    return relation unless present?
    relation
      .then { |result| result.search_name(name) }
      .then { |result| result.search_user(user) }
      .then { |result| result.search_status(*statuses) }
  end
end
