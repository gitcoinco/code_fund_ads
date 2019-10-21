require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
Dotenv::Railtie.load unless Rails.env.production?

module CodeFundAds
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.middleware.use Rack::Attack
    config.middleware.insert_after ActionDispatch::Static, Rack::Deflater
    config.active_record.schema_format = :sql
    config.active_job.queue_adapter = :sidekiq

    # https://github.com/plataformatec/devise/wiki/How-To:-Create-custom-layouts
    config.to_prepare do
      [Devise::SessionsController,
       Devise::RegistrationsController,
       Devise::ConfirmationsController,
       Devise::UnlocksController,
       Devise::PasswordsController,].each do |views|
         views.layout proc { |controller| Rails.env.development? && ENV["REDESIGN"] == "true" ? "application_redesign" : "application" }
       end
    end
  end
end
