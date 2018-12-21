desc "Tasks that to be executed by Heroku Scheduler"
namespace :schedule do
  desc <<~DESC
    Queues updates for total and daily counter caches on campmaigns and properties
    NOTE: This task should be configured to execute on an hourly interval
  DESC
  task counter_updates: :environment do
    SetCampaignCachedCountsJob.perform_later
    SetCampaignCachedCountsJob.set(wait: 30.minutes).perform_later

    SetPropertyCachedCountsJob.set(wait: 5.minute).perform_later
    SetPropertyCachedCountsJob.set(wait: 35.minutes).perform_later
  end
end
