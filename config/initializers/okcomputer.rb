OkComputer::Registry.register "redis-queue", OkComputer::RedisCheck.new(url: ENV["REDIS_QUEUE_URL"])
OkComputer::Registry.register "redis-cache", OkComputer::RedisCheck.new(url: ENV["REDIS_CACHE_URL"])
