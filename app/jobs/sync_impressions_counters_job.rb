# This job should be run as a failsafe... perhaps every 4-8 hours
class SyncImpressionsCountersJob < ApplicationJob
  queue_as :counters_low

  def perform
    Campaign.available.active.each do |campaign|
      sync_daily_count campaign
      sync_total_count campaign
    end
  end

  private

  def sync_daily_count(campaign)
    daily_counter = campaign.daily_impressions_counters.segmented_by(Date.current.iso8601).first
    daily_counter ||= Counter.create(record: campaign, scope: Campaign::DAILY_IMPRESSIONS_COUNT_KEY, segment: Date.current.iso8601)
    count = campaign.impressions.on(Date.current).count + 1
    daily_counter.update_columns count: count
    Rails.cache.write campaign.daily_impressions_count_cache_key(Date.current), count, expires_in: 2.days
  end

  def sync_total_count(campaign)
    total_counter = campaign.total_impressions_counter
    total_counter ||= Counter.create(record: campaign, scope: Campaign::TOTAL_IMPRESSIONS_COUNT_KEY)
    count = campaign.impressions.between(campaign.start_date, campaign.end_date).count + 1
    total_counter.update_columns count: count
    Rails.cache.write campaign.total_impressions_count_cache_key, count, expires_in: (campaign.remaining_operative_days + 7).days
  end
end
