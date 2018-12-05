class SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(user)
    helpers.default_dashboard_path(user)
  end

  def after_sign_out_path_for(_user)
    new_user_session_path
  end
end
