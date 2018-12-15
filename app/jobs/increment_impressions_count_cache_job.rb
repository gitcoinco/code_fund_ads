class IncrementImpressionsCountCacheJob < ApplicationJob
  queue_as :critical

  # TODO: add protections to guard against multiple counts if errros occur
  def perform(impression)
    increment impression.campaign.total_impressions_count_cache_key
    increment impression.campaign.daily_impressions_count_cache_key(Date.current)

    increment impression.property.total_impressions_count_cache_key
    increment impression.property.daily_impressions_count_cache_key(Date.current)
  end

  private

  def increment(cache_key)
    return Rails.cache.write(cache_key, 1) unless Rails.cache.exist?(cache_key)
    Rails.cache.increment cache_key
  end
end
