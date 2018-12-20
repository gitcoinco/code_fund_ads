# Ensures that active campaign counters are in sync (just in case the increment jobs cause drift)
# Scheduled by: config/simple_scheduler.yml
class SetCampaignCachedCountsJob < ApplicationJob
  queue_as :default

  def perform(_scheduled_time = nil)
    Campaign.active.available_on(Date.current).each do |campaign|
      # impressions
      Rails.cache.write campaign.total_impressions_count_cache_key, campaign.impressions.count
      Rails.cache.write campaign.daily_impressions_count_cache_key(Date.current), campaign.impressions.on(Date.current).count

      # clicks
      Rails.cache.write campaign.total_clicks_count_cache_key, campaign.impressions.clicked.count
      Rails.cache.write campaign.daily_clicks_count_cache_key(Date.current), campaign.impressions.on(Date.current).clicked.count
    end
  end
end
