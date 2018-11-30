class RecalculateImpressionCountersJob < ApplicationJob
  queue_as :counters_default

  def perform(campaign_id)
    campaign = Campaign.find_by(id: campaign_id)
    return unless campaign

    initialize_counter campaign
  end
end
