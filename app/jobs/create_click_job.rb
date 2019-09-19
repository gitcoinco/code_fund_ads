class CreateClickJob < ApplicationJob
  queue_as :click

  def perform(impression_id, campaign_id, clicked_at_string)
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    campaign = Campaign.find_by(id: campaign_id)
    return unless campaign&.standard?

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
    Impression.where(id: impression_id).between(1.day.ago, Date.current)
      .update_all(clicked_at: clicked_at, clicked_at_date: clicked_at.to_date)

    impression.track_event :impression_clicked

    return unless campaign.creative_ids.size > 1
    return unless impression.creative

    split_experiment = Split::ExperimentCatalog.find_or_create(campaign.split_test_name, *campaign.split_alternative_names)
    split_user = Split::User.new(impression.id)
    split_trial = Split::Trial.new(user: split_user, experiment: split_experiment, alternative: impression.creative.split_test_name)
    split_trial.complete!
  end
end
