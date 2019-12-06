module Scopable
  extend ActiveSupport::Concern

  included do
    helper_method :scope_list
    before_action :reset_current_scope
  end

  def scope_list(model)
    model.public_send(current_scope)
  end

  private

  def current_scope
    session[:current_scope].present? ? session[:current_scope] : scope_by
  end

  def scope_by
    session[:scope_by]&.to_sym || :all
  end

  def reset_current_scope
    session[:current_scope] = session[:last_controller_name] != controller_name ? :all : ""
    session[:last_controller_name] = controller_name
  end
end
