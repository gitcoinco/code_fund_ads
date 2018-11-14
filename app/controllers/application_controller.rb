# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action -> { cookies.encrypted[:example_id] ||= SecureRandom.uuid }
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:accept_invitation, keys: [:first_name, :last_name, :company_name])
      devise_parameter_sanitizer.permit(:invite, keys: [:first_name, :last_name, :company_name, roles: []])
    end

    def after_invite_path_for(inviter, invitee = nil)
      users_path
    end
end
