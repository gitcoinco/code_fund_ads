# Ensures that active property counters are in sync (just in case the increment jobs cause drift)
# Scheduled via Heroku Scheduler
# SEE: lib/tasks/schedule.rake
class SetPropertyCachedCountsJob < ApplicationJob
  queue_as :default

  def perform
    Property.active.find_each do |property|
      # impressions
      Rails.cache.write property.total_impressions_count_cache_key, property.impressions.count
      Rails.cache.write property.daily_impressions_count_cache_key(Date.current), property.impressions.on(Date.current).count

      # clicks
      Rails.cache.write property.total_clicks_count_cache_key, property.impressions.clicked.count
      Rails.cache.write property.daily_clicks_count_cache_key(Date.current), property.impressions.on(Date.current).clicked.count
    end
  end
end
