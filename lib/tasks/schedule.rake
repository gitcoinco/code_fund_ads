desc "Tasks to be executed by Heroku Scheduler"
namespace :schedule do
  desc <<~DESC
    Queues job that updates total and daily counter caches on campmaigns and properties
    NOTE: Schedule hourly
  DESC
  task counter_updates: :environment do
    SetCampaignCachedCountsJob.perform_later
    SetCampaignCachedCountsJob.set(wait: 30.minutes).perform_later

    SetPropertyCachedCountsJob.set(wait: 5.minute).perform_later
    SetPropertyCachedCountsJob.set(wait: 35.minutes).perform_later
  end

  desc <<~DESC
    Queues job that marks expired campaigns as archived
    NOTE: Schedule daily
  DESC
  task update_campaign_statuses: :environment do
    UpdateCampaignStatusesJob.perform_later
  end

  desc <<~DESC
    Queues job that creates transactions for daily campaign spend
    NOTE: Schedule daily
  DESC
  task create_debits_for_campaigns: :environment do
    CreateDebitsForCampaignsJob.perform_later
  end

  desc <<~DESC
    Queues job that imports Github Jobs
    NOTE: Schedule daily
  DESC
  task import_github_jobs: :environment do
    tags = ENUMS::KEYWORDS.values.flatten.uniq.sort
    ImportGithubJobsJob.perform_later(*tags)
  end
end
