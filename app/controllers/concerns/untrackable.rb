module Untrackable
  extend ActiveSupport::Concern

  included do
    around_action :prevent_tracking
  end

  protected

  def prevent_tracking
    return if current_user&.persisted? # do not kick authenticated users off when previewing ads
    session.clear
    request.session_options[:skip] = true
    cookies.clear
  end
end
