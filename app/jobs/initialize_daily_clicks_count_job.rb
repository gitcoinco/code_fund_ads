class InitializeDailyClicksCountJob < ApplicationJob
  queue_as :counters_default

  def perform(campaign_id, date_string)
    campaign = Campaign.find_by(id: campaign_id)
    return unless campaign
    date = Date.parse(date_string)
    initialize_counter campaign, date
  end

  private

  def initialize_counter(campaign, date)
    count = campaign.impressions.clicked.on(date).count
    counter = Counter.where(record: campaign, scope: Campaign::DAILY_CLICKS_COUNT_KEY, segment: date.iso8601).first_or_initialize(count: count)
    counter.save!
  end
end
