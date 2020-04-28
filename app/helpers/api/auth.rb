module API::Auth

  def warden
    env['warden']
  end

  def authenticated?
    if warden.authenticated?
      return true
    elsif params[:api_key] and
      @current_user = User.where(api_key: params[:api_key]).first
    else
      error!({"error" => "Token invalid or expired"}, 401)
    end
  end

  def administrator?
    authenticated? && current_user.administrator?
  end

  def current_user
    @current_user
  end

end