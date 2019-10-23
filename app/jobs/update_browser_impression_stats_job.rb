class UpdateBrowserImpressionStatsJob < ApplicationJob
  include CableReady::Broadcaster
  queue_as :low

  def perform
    cable_ready["general:home#show"].text_content(selector: "#global-properties-count", text: Property.active.count)
    cable_ready["general:home#show"].text_content(selector: "#global-click-rate", text: ImpressionStats.click_rate)
    cable_ready["general:home#show"].text_content(selector: "#global-impressions-count", text: ImpressionStats.count)
    cable_ready.broadcast

    existing_scheduled_job = Sidekiq::ScheduledSet.new.find { |job| job.queue == queue_name && job.args.first["job_class"] == self.class.name }
    UpdateBrowserImpressionStatsJob.set(wait: 5.seconds).perform_later unless existing_scheduled_job
  end
end
