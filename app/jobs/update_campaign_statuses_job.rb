# Ensures that campaigns are set to archived once their end_date has passed
# Scheduled via Heroku Scheduler
# SEE: lib/tasks/schedule.rake
class UpdateCampaignStatusesJob < ApplicationJob
  queue_as :default

  def perform
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    Campaign.active.find_each do |campaign|
      next unless campaign.end_date.past?
      campaign.update status: ENUMS::CAMPAIGN_STATUSES::ARCHIVED
    end
  end
end
