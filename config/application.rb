require_relative "boot"

require "rails/all"

require "view_component/engine"

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

    config.active_record.schema_format = :sql
    config.active_job.queue_adapter = :sidekiq
    config.exceptions_app = routes
    config.annotations.register_tags("DEPRECATE")

    config.generators do |g|
      g.assets false
      g.stylesheets false
    end
  end
end
