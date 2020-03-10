# Scheduled via Heroku Scheduler
# SEE: lib/tasks/schedule.rake
class CreateDebitsForCampaignsJob < ApplicationJob
  queue_as :create_debits_for_campaign_and_date

  def perform
    ScoutApm::Transaction.ignore! if rand > (ENV["SCOUT_SAMPLE_RATE"] || 1).to_f
    start_date = 10.days.ago.to_date # go back 10 days to pick up any that may have been missed
    end_date = 1.day.ago.to_date
    (start_date..end_date).each do |date|
      Campaign.select(:id).available_on(date).find_each do |campaign|
        CreateDebitForCampaignAndDateJob.perform_later campaign.id, date.iso8601
      end
    end
  end
end
