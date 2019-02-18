class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def linkedin
    register(request.env["omniauth.auth"])
  end

  def github
    access_token = request.env["omniauth.auth"]
    raw_info = access_token.dig(:extra, :raw_info)
    register(access_token, {
      roles: [ENUMS::USER_ROLES::EMPLOYER],
      full_name: raw_info[:name],
      company_name: raw_info[:company],
      bio: raw_info[:bio],
      website_url: raw_info[:blog],
      github_username: raw_info[:login],
    })
  end

  def google_oauth2
    register(request.env["omniauth.auth"])
  end

  private

  def register(access_token, extras = {})
    @user = User.from_omniauth(access_token, extras)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Google"
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.google_data"] = access_token.except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end
end
