Split.configure do |config|
  config.algorithm = Split::Algorithms::Whiplash # multi-armed bandit
  config.winning_alternative_recalculation_interval = 3600 # 1 hour
  config.persistence = :cookie
  config.persistence_cookie_length = 2.hours.seconds.to_i
end

Split.redis = ENV["REDIS_CACHE_URL"]
