class IncrementTotalImpressionsCountJob < ApplicationJob
  queue_as :counters_critical

  def perform(campaign_id)
    campaign = Campaign.find_by(id: campaign_id)
    return unless campaign

    counter = campaign.total_impressions_counter
    return InitializeTotalImpressionsCountJob.perform_later(campaign_id) unless counter

    increment campaign, counter
  end

  private

  def increment(campaign, counter)
    counter.update_columns count: counter.count + 1
    Rails.cache.write campaign.total_impressions_count_cache_key, counter.count, expires_in: (campaign.remaining_operative_days + 7).days
  end
end
