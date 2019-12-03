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
    "#{sort_column} #{sort_direction} NULLS LAST"
  end

  def sort_column
    return column if sortable_columns.include?(column)
    return "name" if sortable_columns.include?("name")
    "created_at"
  end

  def sort_direction
    @sort_direction ||= %w[asc desc].include?(direction) ? direction : "asc"
  end

  # For Paginator
  def sort_by
    @sort_by ||= sort_column
  end

  def query
    @query ||= order_by
  end

  private

  def column
    params[:column] || session[:sort_by]
  end

  def direction
    params[:direction] || session[:sort_direction]
  end
end
