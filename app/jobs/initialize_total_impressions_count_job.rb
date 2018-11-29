class InitializeTotalImpressionsCountJob < ApplicationJob
  queue_as :counters_default

  def perform(campaign_id)
    campaign = Campaign.find_by(id: campaign_id)
    return unless campaign
    initialize_counter campaign
  end

  private

  def initialize_counter(campaign)
    count = campaign.impressions.between(campaign.start_date, campaign.end_date).count
    counter = Counter.where(record: campaign, scope: Campaign::TOTAL_IMPRESSIONS_COUNT_KEY).first_or_initialize(count: count)
    counter.save!
    Rails.cache.write campaign.total_impressions_count_cache_key, counter.count, expires_in: (campaign.remaining_operative_days + 7).days
  end
end
