# frozen_string_literal: true

class CampaignSearch < ApplicationSearchRecord
  def initialize(attrs = {})
    super %w[name user], attrs
  end

  def name
    @attributes[:name]
  end

  def user
    @attributes[:user]
  end

  def apply(relation)
    return relation unless present?
    relation
      .then { |result| result.search_name(name) }
      .then { |result| result.search_user(user) }
  end
end
