class CreateClickJob < ApplicationJob
  queue_as :click

  def perform(impression_id, campaign_id, clicked_at_string)
    campaign = Campaign.find_by(id: campaign_id)
    return unless campaign

    clicked_at = Time.parse(clicked_at_string)
    impression = Impression.partitioned(campaign.user, clicked_at.advance(months: -1), clicked_at.advance(weeks: 1)).find_by(id: impression_id)

    # reattempt for up to 10 minutes if we didn't find the impression
    # NOTE: sidekiq is configured to drain the impression queue before dequeuing any click jobs
    # SEE: config/sidekiq.yml
    if impression.nil? && clicked_at >= 10.minutes.ago
      return CreateClickJob.set(wait: 1.minute).perform_later(impression_id, campaign_id, clicked_at_string)
    end

    return if impression.nil? || impression.clicked?

    clicked_at = Time.parse(clicked_at_string)
    records_saved = Impression.partitioned(campaign.user, 1.day.ago, Date.current).
      where(id: impression_id).update_all(clicked_at: clicked_at, clicked_at_date: clicked_at.to_date)
    IncrementClicksCountCacheJob.perform_now impression if records_saved > 0
  end
end
