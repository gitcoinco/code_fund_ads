module Untrackable
  extend ActiveSupport::Concern

  included do
    prepend_before_action :prevent_tracking
    after_action :prevent_tracking
  end

  protected

  def prevent_tracking
    return if current_user&.persisted? # do not kick authenticated users off when previewing ads
    session.clear
    request.session_options[:skip] = true
    cookies.clear
  end
end
