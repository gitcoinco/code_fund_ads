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
    current = session[:current_scope]
    current = scope_by unless current && scope_by != current
    current
  end

  def scope_by
    session[:scope_by]&.to_sym || :all
  end

  def reset_current_scope
    session[:current_scope] = :all if session[:last_controller_name] != controller_name
    session[:last_controller_name] = controller_name
  end
end
