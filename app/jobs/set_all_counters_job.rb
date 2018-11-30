# This job should be run as a failsafe... perhaps every 1-2 days
class SetAllCountersJob < ApplicationJob
  queue_as :counters_default

  def perform
    Campaign.available.active.each do |campaign|
      UpdateCountersJob.perform_later campaign
    end
  end
end
