# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action -> { cookies.encrypted[:example_id] ||= SecureRandom.uuid }

  layout :layout_by_resource

  private

    def layout_by_resource
      if devise_controller? && !current_user
        "authentication"
      else
        "application"
      end
    end
end
