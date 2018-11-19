class CalculateDailyImpressionsCountJob < ApplicationJob
  queue_as :default

  def perform(campaign, date_string)
    date = Date.parse(date_string)
    cache_key = campaign.daily_impressions_count_cache_key(date)
    Rails.cache.redis.set cache_key, campaign.impressions.where(displayed_at_date: date).count
  end
end
