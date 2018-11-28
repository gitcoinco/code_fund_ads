Sidekiq.configure_server do |config|
  config.redis = {url: ENV["REDIS_QUEUE_URL"]}
end

Sidekiq.configure_client do |config|
  config.redis = {url: ENV["REDIS_QUEUE_URL"]}
end
