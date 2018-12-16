class IncrementImpressionsCountCacheJob < ApplicationJob
  queue_as :critical

  # TODO: add protections to guard against multiple counts if errros occur
  def perform(impression)
    Rails.cache.write(
      impression.campaign.total_impressions_count_cache_key,
      impression.campaign.total_impressions_count.to_i + 1
    )

    Rails.cache.write(
      impression.campaign.daily_impressions_count_cache_key(Date.current),
      impression.campaign.daily_impressions_count(Date.current).to_i + 1
    )

    Rails.cache.write(
      impression.property.total_impressions_count_cache_key,
      impression.property.total_impressions_count.to_i + 1
    )

    Rails.cache.write(
      impression.property.daily_impressions_count_cache_key(Date.current),
      impression.property.daily_impressions_count(Date.current).to_i + 1
    )
  end
end
