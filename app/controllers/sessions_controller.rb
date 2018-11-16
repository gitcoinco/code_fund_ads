class SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(_user)
    dashboard_path
  end

  def after_sign_out_path_for(_user)
    new_user_session_path
  end
end
