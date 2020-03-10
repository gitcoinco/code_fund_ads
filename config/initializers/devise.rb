# For a complete reference to available options see the default initializer here:
# https://github.com/plataformatec/devise/blob/master/lib/generators/templates/devise.rb

Devise.setup do |config|
  config.mailer_sender = "support@codefund.io"

  config.mailer = "DeviseMailer"

  config.parent_mailer = "ActionMailer::Base"

  require "devise/orm/active_record"

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 11

  config.send_email_changed_notification = true

  config.send_password_change_notification = true

  config.invite_for = 2.weeks

  config.invite_key = {
    email: /\A[^@]+@[^@]+\z/,
    first_name: /\A.+\z/,
    last_name: /\A.+\z/
  }

  config.validate_on_invite = true

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 6..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.timeout_in = 12.hours

  config.lock_strategy = :failed_attempts

  config.unlock_strategy = :both

  config.maximum_attempts = 10

  config.reset_password_within = 6.hours

  config.sign_out_via = :get

  # config.omniauth :github, ENV["GITHUB_CLIENT_ID"], ENV["GITHUB_CLIENT_SECRET"], scope: "read:user,user:email"

  ActiveSupport.on_load(:devise_failure_app) do
    include Turbolinks::Controller
  end
end

# https://github.com/plataformatec/devise/wiki/How-To:-Create-custom-layouts
Rails.application.config.to_prepare do
  Devise::SessionsController.layout "authentication"
  Devise::RegistrationsController.layout proc { |controller| user_signed_in? ? "application" : "authentication" }
  Devise::ConfirmationsController.layout "authentication"
  Devise::UnlocksController.layout "authentication"
  Devise::PasswordsController.layout "authentication"
end
