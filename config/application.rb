require_relative "boot"

# only require Rails libraries that we actually use, this shaves off some memory
# ActionMailbox and ActionText are not currently used by the app
# see https://github.com/rails/rails/blob/v6.0.2.1/railties/lib/rails/all.rb
%w[
  active_record/railtie
  active_storage/engine
  action_controller/railtie
  action_view/railtie
  action_mailer/railtie
  active_job/railtie
  action_cable/engine
  rails/test_unit/railtie
  sprockets/railtie
].each do |lib|
  require lib
end

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
