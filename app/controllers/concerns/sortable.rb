module Sortable
  extend ActiveSupport::Concern

  module ClassMethods
    def set_default_sorted_by(value)
      @default_sorted_by = value.to_s
    end

    def default_sorted_by
      @default_sorted_by || "created_at"
    end

    def set_default_sorted_direction(value)
      @default_sorted_direction = value.to_s
    end

    def default_sorted_direction
      @default_sorted_direction || "asc"
    end
  end

  included do
    before_action :set_sortable_columns, :set_sorted_by, :set_sorted_direction, :set_page, only: [:index, :show]
  end

  def order_by
    "#{@sorted_by} #{@sorted_direction} NULLS LAST"
  end

  protected

  def set_sorted_by
    @sorted_by ||= begin
      column = params[:sorted_by]
      column = self.class.default_sorted_by unless @sortable_columns.include?(column)
      column
    end
  end

  def set_sorted_direction
    @sorted_direction ||= params[:sorted_direction] || self.class.default_sorted_direction
  end

  def set_page
    @page = (@page || params[:page] || 1).to_i
  end

  # Abstract method that should be overridden in including controllers
  def set_sortable_columns
    raise NotImplementedError, "controller should implement `set_sortable_columns`"
  end
end
