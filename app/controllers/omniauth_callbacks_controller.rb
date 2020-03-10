class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    access_token = request.env["omniauth.auth"]
    raw_info = access_token.dig(:extra, :raw_info)
    register(access_token, {
      roles: [ENUMS::USER_ROLES::EMPLOYER],
      full_name: raw_info[:name],
      company_name: raw_info[:company],
      bio: raw_info[:bio],
      website_url: raw_info[:blog],
      github_username: raw_info[:login]
    })
  end

  protected

  def after_sign_in_path_for(user)
    helpers.default_dashboard_path user
  end

  private

  def register(access_token, extras = {})
    @user = User.from_omniauth(access_token, extras)

    if @user.persisted?
      # Confirm email unless already confirmed
      @user.update(confirmed_at: Time.current) unless @user.confirmed_at.present?

      flash[:notice] = "Successfully authenticated"
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.oauth_data"] = access_token.except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_session_url, alert: @user.errors.full_messages.join("\n")
    end
  end
end
