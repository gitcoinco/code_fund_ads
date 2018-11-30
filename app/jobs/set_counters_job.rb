# This job should be run as a failsafe... perhaps every 2-4 days
class SetCountersJob < ApplicationJob
  queue_as :counters_low

  def perform(campaign)
    campaign.dates_with_payable_impressions.each do |date|
      SetImpressionCounterJob.perform_later campaign, date.iso8601
      SetClickCounterJob.perform_later campaign, date.iso8601
    end
  end
end
