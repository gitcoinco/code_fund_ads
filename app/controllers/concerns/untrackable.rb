module Untrackable
  extend ActiveSupport::Concern

  included do
    before_action :prevent_tracking
    after_action :prevent_tracking
  end

  protected

  def prevent_tracking
    return if current_user&.persisted? # do not kick authenticated users off when previewing ads
    cookies.clear
    session.clear
  end
end
