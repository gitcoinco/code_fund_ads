class IncrementDailyImpressionsCountJob < ApplicationJob
  queue_as :counters_critical

  def perform(campaign_id, date_string)
    campaign = Campaign.find_by(id: campaign_id)
    return unless campaign

    date = Date.parse(date_string)
    counter = campaign.daily_impressions_counters.segmented_by(date.iso8601).first
    return InitializeDailyImpressionsCountJob.perform_later(campaign_id, date_string) unless counter

    increment campaign, date, counter
  end

  private

  def increment(campaign, date, counter)
    counter.update_columns count: counter.count + 1
    Rails.cache.write campaign.daily_impressions_count_cache_key(date), counter.count, expires_in: 2.days
  end
end
