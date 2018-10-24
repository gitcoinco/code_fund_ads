# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action -> { cookies.encrypted[:example_id] ||= SecureRandom.uuid }
end
