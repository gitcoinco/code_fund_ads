class SplitNoPersistenceAdapter
  def initialize(context)
    @context = context
  end

  def [](key)
  end

  def []=(key, value)
  end

  def delete(key)
  end

  def keys
    []
  end
end

Split.configure do |config|
  config.algorithm = Split::Algorithms::Whiplash # multi-armed bandit
  config.winning_alternative_recalculation_interval = 3600 # 1 hour
  config.persistence = SplitNoPersistenceAdapter
end

Split.redis = ENV["REDIS_CACHE_URL"]
