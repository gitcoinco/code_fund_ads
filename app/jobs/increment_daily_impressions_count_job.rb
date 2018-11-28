class IncrementDailyImpressionsCountJob < ApplicationJob
  queue_as :counters_critical

  def perform(campaign_id, date_string)
    campaign = Campaign.find_by(id: campaign_id)
    return unless campaign

    date = Date.parse(date_string)
    counter = campaign.daily_impressions_counters.segmented_by(date.iso8601).first
    return increment(campaign, counter, date) if counter

    initialize_counter campaign, date
  end

  private

  def initialize_counter(campaign, date)
    count = campaign.impressions.on(date).count
    counter = campaign.daily_impressions_counters.build(segment: date.iso8601, count: count)
    counter.save!
    increment campaign, counter, date
  end

  def increment(campaign, counter, date)
    count = counter.count + 1
    counter.update_columns count: count
    Rails.cache.write campaign.daily_impressions_count_cache_key(date), count, expires_in: 2.days
  end
end
