class IncrementImpressionsCountJob < ApplicationJob
  queue_as :counters_critical

  def perform(impression)
    relation = ImpressionCounter.on(impression.displayed_at_date).
      where(campaign_id: impression.campaign_id, property_id: impression.property_id)

    if relation.exists?
      counter = relation.first
      counter.with_lock { counter.update_columns count: counter.count + 1 }
    else
      relation.create! count: Impression.on(impression.displayed_at_date).
        where(campaign_id: impression.campaign_id, property_id: impression.property_id).
        count
    end

    Rails.cache.redis.incr campaign.total_impressions_count_cache_key
    Rails.cache.redis.incr campaign.daily_impressions_count_cache_key(date)

    # TODO: add property redis cache counters
  end
end
