if Rails.env.production?
  Rails.application.config.cloudflare.expires_in = 12.hours # default value
  Rails.application.config.cloudflare.timeout = 5.seconds # default value
end
