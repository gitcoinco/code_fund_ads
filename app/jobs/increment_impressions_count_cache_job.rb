class IncrementImpressionsCountCacheJob < ApplicationJob
  queue_as :default

  # TODO: add protections to guard against multiple counts if errors occur
  def perform(impression)
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    Rails.cache.redis.incr impression.campaign.total_impressions_count_cache_key
    Rails.cache.redis.incr impression.campaign.daily_impressions_count_cache_key(Date.current)
    Rails.cache.redis.incr impression.property.total_impressions_count_cache_key
    Rails.cache.redis.incr impression.property.daily_impressions_count_cache_key(Date.current)
  end
end
