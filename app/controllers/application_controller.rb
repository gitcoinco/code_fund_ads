# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action -> { cookies.encrypted[:example_id] ||= SecureRandom.uuid }

  # NOTE: The `authorizer` instance variable should be setup
  #       via a before_action in each controller when appropriate
  attr_reader :authorizer

  # The authorizer is also made available to views
  helper_method :authorizer

  protected

    def render_not_found
      render file: Rails.public_path.join("404.html"), status: :not_found, layout: false
    end

    def render_forbidden
      render file: Rails.public_path.join("403.html"), status: :forbidden, layout: false
    end
end
