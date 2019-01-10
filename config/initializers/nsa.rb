statsd = ::Statsd.new(ENV["STATSD_HOST"], ENV["STATSD_PORT"])
application_name = ::Rails.application.class.parent_name.underscore
application_env = ENV["PLATFORM_ENV"] || ::Rails.env
statsd.namespace = [application_name, application_env].join(".")

::NSA.inform_statsd(statsd) do |informant|
  # Load :action_controller collector with a key prefix of :web
  informant.collect(:action_controller, :web)
  informant.collect(:active_record, :db)
  informant.collect(:cache, :cache)
  informant.collect(:sidekiq, :sidekiq)
end
