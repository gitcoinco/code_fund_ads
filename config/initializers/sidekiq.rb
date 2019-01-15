Sidekiq.configure_server do |config|
  config.redis = {url: ENV["REDIS_QUEUE_URL"], size: ENV.fetch("RAILS_MAX_THREADS") { 5 }}
end

Sidekiq.configure_client do |config|
  config.redis = {url: ENV["REDIS_QUEUE_URL"], size: ENV.fetch("RAILS_MAX_THREADS") { 5 }}
end
