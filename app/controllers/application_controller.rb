# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action -> { cookies.encrypted[:example_id] ||= SecureRandom.uuid }
  before_action :configure_permitted_parameters, if: :devise_controller?

  # NOTE: The `authorizable` instance variable should be setup
  #       with a `before_action` in each controller when appropriate
  attr_reader :authorizable

  # The `authorizable` variable is made available to views
  helper_method :authorizable

  protected

    def render_not_found
      render file: Rails.public_path.join("404.html"), status: :not_found, layout: false
    end

    def render_forbidden
      render file: Rails.public_path.join("403.html"), status: :forbidden, layout: false
    end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:accept_invitation, keys: [:first_name, :last_name, :company_name])
      devise_parameter_sanitizer.permit(:invite, keys: [:first_name, :last_name, :company_name, roles: []])
    end

    def after_invite_path_for(inviter, invitee = nil)
      users_path
    end
end
