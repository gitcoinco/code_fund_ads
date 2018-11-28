class IncrementTotalImpressionsCountJob < ApplicationJob
  queue_as :counters_default

  def perform(campaign_id)
    campaign = Campaign.find_by(id: campaign_id)
    return unless campaign

    counter = campaign.total_impressions_counter
    return increment(campaign, counter) if counter

    initialize_counter campaign
  end

  private

  def initialize_counter(campaign)
    count = campaign.impressions.between(campaign.start_date, campaign.end_date).count
    counter = Counter.create(record: campaign, scope: Campaign::TOTAL_IMPRESSIONS_COUNT_KEY, count: count)
    increment campaign, counter
  end

  def increment(campaign, counter)
    count = counter.count + 1
    counter.update_columns count: count
    Rails.cache.write campaign.total_impressions_count_cache_key, count, expires_in: (campaign.remaining_operative_days + 7).days
  end
end
