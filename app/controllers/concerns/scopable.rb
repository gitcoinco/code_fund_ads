module Scopable
  extend ActiveSupport::Concern

  included do
    before_action :set_scoped_by, :set_scopable_values, only: :index
  end

  def scope_list(model)
    return model unless @scopable_values.include?(@scoped_by)
    model.public_send(@scoped_by)
  end

  protected

  def set_scoped_by
    @scoped_by ||= params[:scoped_by] || "all"
  end

  # Abstract method that should be overridden in including controllers
  def set_scopable_values
    raise NotImplementedError, "controller should implement `set_scopable_values`"
  end
end
