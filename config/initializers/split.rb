Split.configure do |config|
  config.algorithm = Split::Algorithms::Whiplash # multi-armed bandit
  config.winning_alternative_recalculation_interval = 3600 # 1 hour
  config.persistence = Split::Persistence::RedisAdapter.with_config(
    lookup_by: ->(context) { context&.session&.id },
    namespace: "splitrb",
    expire_seconds: 30,
  )
end

Split.redis = Rails.cache.redis
