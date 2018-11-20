class CalculateDailyImpressionsCountJob < ApplicationJob
  queue_as :default

  def perform(campaign, date_string)
    date = Date.parse(date_string)
    key = campaign.daily_impressions_count_cache_key(date)
    value = campaign.impressions.where(displayed_at_date: date).count
    Rails.cache.redis.set key, value, ex: 4.days.seconds
  end
end
