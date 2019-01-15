Sidekiq.configure_server do |config|
  config.redis = {url: ENV["REDIS_QUEUE_URL"], size: (ENV.fetch("RAILS_MAX_THREADS") { 10 }).to_i}
end

Sidekiq.configure_client do |config|
  config.redis = {url: ENV["REDIS_QUEUE_URL"], size: (ENV.fetch("RAILS_MAX_THREADS") { 10 }).to_i}
end
