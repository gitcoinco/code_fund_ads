class IncrementImpressionsCountCacheJob < ApplicationJob
  queue_as :default

  # TODO: add protections to guard against multiple counts if errors occur
  def perform(impression)
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
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
