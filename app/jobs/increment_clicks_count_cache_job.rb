class IncrementClicksCountCacheJob < ApplicationJob
  queue_as :critical

  # TODO: add protections to guard against multiple counts if errros occur
  def perform(impression)
    Rails.cache.redis.incr impression.campaign.total_clicks_count_cache_key
    Rails.cache.redis.incr impression.campaign.daily_clicks_count_cache_key(Date.current)

    Rails.cache.redis.incr impression.property.total_clicks_count_cache_key
    Rails.cache.redis.incr impression.property.daily_clicks_count_cache_key(Date.current)
  end
end
