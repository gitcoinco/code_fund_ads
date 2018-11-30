# This job should be run as a failsafe... perhaps every 4-8 hours
class SyncImpressionsCountersJob < ApplicationJob
  queue_as :counters_low

  def perform
    Campaign.available.active.each do |campaign|
      InitializeDailyImpressionsCountJob.perform_now campaign.id, Date.current.iso8601
      InitializeTotalImpressionsCountJob.perform_now campaign.id
      InitializeDailyClicksCountJob.perform_now campaign.id, Date.current.iso8601
      InitializeTotalClicksCountJob.perform_now campaign.id
    end
  end
end
