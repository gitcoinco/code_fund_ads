class SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(user)
    dashboard_path(user.advertiser? ? "advertiser" : "publisher")
  end

  def after_sign_out_path_for(_user)
    new_user_session_path
  end
end
