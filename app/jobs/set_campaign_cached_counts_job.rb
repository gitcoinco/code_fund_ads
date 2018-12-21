# Ensures that active campaign counters are in sync (just in case the increment jobs cause drift)
# Scheduled via Heroku Scheduler
# SEE: lib/tasks/schedule.rake
class SetCampaignCachedCountsJob < ApplicationJob
  queue_as :default

  def perform
    Campaign.active.available_on(Date.current).find_each do |campaign|
      # impressions
      Rails.cache.write campaign.total_impressions_count_cache_key, campaign.impressions.count
      Rails.cache.write campaign.daily_impressions_count_cache_key(Date.current), campaign.impressions.on(Date.current).count

      # clicks
      Rails.cache.write campaign.total_clicks_count_cache_key, campaign.impressions.clicked.count
      Rails.cache.write campaign.daily_clicks_count_cache_key(Date.current), campaign.impressions.on(Date.current).clicked.count
    end
  end
end
