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
    @current_scope ||= session[:scope_by]&.to_sym || :all
  end

  def reset_current_scope
    if session[:last_controller_name] != controller_name
      session[:scope_by] = nil
    end
  end
end
