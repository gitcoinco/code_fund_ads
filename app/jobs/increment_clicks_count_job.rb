class IncrementClicksCountJob < ApplicationJob
  queue_as :counters_critical

  def perform(impression)
    return unless impression.payable?
    return if impression.clicked_at.nil?

    relation = ClickCounter.on(impression.clicked_at.to_date).
      where(campaign_id: impression.campaign_id, property_id: impression.property_id)

    if relation.exists?
      counter = relation.first
      counter.with_lock { counter.update_columns count: counter.count + 1 }
    else
      relation.create! count: Impression.clicked.on(impression.clicked_at.to_date).
        where(campaign_id: impression.campaign_id, property_id: impression.property_id).
        count
    end

    Rails.cache.redis.incr campaign.total_clicks_count_cache_key
    Rails.cache.redis.incr campaign.daily_clicks_count_cache_key(date)

    # TODO: add property redis cache counters
  end
end
