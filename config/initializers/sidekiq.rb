Sidekiq.configure_server do |config|
  config.redis = {url: ENV["REDIS_QUEUE_URL"], size: ENV.fetch("REDIS_QUEUE_MAX_THREADS", 5).to_i}
end

Sidekiq.configure_client do |config|
  config.redis = {url: ENV["REDIS_QUEUE_URL"], size: ENV.fetch("REDIS_QUEUE_MAX_THREADS", 5).to_i}
end
