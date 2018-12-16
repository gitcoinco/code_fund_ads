Mailgun.configure do |config|
  config.api_key = ENV["MAILGUN_API_KEY"]
end

Rails.application.config.action_mailer.delivery_method = :mailgun
Rails.application.config.action_mailer.mailgun_settings = {
  api_key: ENV["MAILGUN_API_KEY"],
  domain: ENV["MAILGUN_DOMAIN"],
}
