# frozen_string_literal: true

module Sortable
  extend ActiveSupport::Concern

  included do
    helper_method :sort_column, :sort_direction
  end

  # Abstract method that should be overridden in including controllers
  def sortable_columns
    raise NotImplementedError, "controller should include method `sortable_columns`"
  end

  def order_by
    "#{sort_column} #{sort_direction}"
  end

  def sort_column
    return params[:column] if sortable_columns.include?(params[:column])
    return "name"          if sortable_columns.include?("name")
    "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
