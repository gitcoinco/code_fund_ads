class InitializeTotalClicksCountJob < ApplicationJob
  queue_as :counters_default

  def perform(campaign_id)
    campaign = Campaign.find_by(id: campaign_id)
    return unless campaign
    initialize_counter campaign
  end

  private

  def initialize_counter(campaign)
    count = campaign.impressions.clicked.between(campaign.start_date, campaign.end_date).count
    counter = Counter.where(record: campaign, scope: Campaign::TOTAL_CLICKS_COUNT_KEY).first_or_initialize(count: count)
    counter.save!
  end
end
