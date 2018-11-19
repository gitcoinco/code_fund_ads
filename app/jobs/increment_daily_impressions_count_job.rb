class IncrementDailyImpressionsCountJob < ApplicationJob
  queue_as :default

  def perform(campaign_id, date_string)
    campaign = Campaign.find(campaign_id)
    date = Date.parse(date_string)
    cache_key = campaign.daily_impressions_count_cache_key(date)
    return Rails.cache.redis.incr(cache_key) if Rails.cache.redis.exists(cache_key)
    CalculateDailyImpressionsCountJob.perform_now campaign, date_string
  end
end
