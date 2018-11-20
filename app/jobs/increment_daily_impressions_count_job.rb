class IncrementDailyImpressionsCountJob < ApplicationJob
  queue_as :default

  def perform(campaign_id, date_string)
    campaign = Campaign.find(campaign_id)
    date = Date.parse(date_string)
    key = campaign.daily_impressions_count_cache_key(date)
    return Rails.cache.redis.incr(key) if Rails.cache.redis.exists(key)
    CalculateDailyImpressionsCountJob.perform_now campaign, date_string
  end
end
