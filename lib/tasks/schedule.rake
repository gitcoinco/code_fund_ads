desc "Tasks to be executed by Heroku Scheduler"
namespace :schedule do
  desc <<~DESC
    Applies the data retention policy by detaching old partition tables from impressions
    NOTE: Schedule daily
  DESC
  task apply_data_retention_policy: :environment do
    Impression.detach_old_tables
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

  desc <<~DESC
    Queues job that ensures daily_summaries have been created for campaigns and properties
    NOTE: Schedule daily
  DESC
  task daily_summaries: :environment do
    EnsureDailySummariesJob.perform_later
  end

  desc <<~DESC
    Queues job that ensures scoped daily_summaries have been created for campaigns and properties
    - campaigns scoped by property
    - properties scoped by campaign
    NOTE: Schedule daily
  DESC
  task scoped_daily_summaries: :environment do
    EnsureScopedDailySummariesJob.perform_later
  end

  desc <<~DESC
    Queues job that recalculates all organization balances
    NOTE: Schedule daily
  DESC
  task recalculate_organization_balances: :environment do
    RecalculateOrganizataionBalancesJob.perform_later
  end

  desc <<~DESC
    Queues job that fetches traffic data for properties
    NOTE: Schedule daily
  DESC
  task capture_traffic_estimates: :environment do
    Property.without_estimates.each do |property|
      EstimateTrafficForPropertyJob.perform_later(property.id)
    end
  end

  desc <<~DESC
    Queues job that checks for a dramatic drop in impressions for properties
    NOTE: Schedule daily
  DESC
  task property_impressions_drop: :environment do
    PropertyImpressionsDropNotificationJob.perform_later
  end
end
