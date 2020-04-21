require "progressbar"

namespace :jobs do
  desc "Import jobs from RemoteOK.io"
  task import_remoteok: :environment do
    tags = %w[dev javascript ruby go python c dotnet elixir]
    ImportRemoteokJobsJob.new.perform(*tags)
    puts "There are #{JobPosting.count} jobs"
  end

  desc "Import jobs from GitHub"
  task import_github: :environment do
    tags = ENUMS::KEYWORDS.values.flatten.uniq.sort
    ImportGithubJobsJob.new.perform(*tags)
    puts "There are #{JobPosting.count} jobs"
  end

  desc "Sync campaign data with Zapier"
  task sync_to_zapier: :environment do
    SyncToZapierJob.new.perform
  end

  desc "Update daily summaries with missing fallback click count"
  task update_daily_summary_fallback_click_counts: :environment do
    progressbar = ProgressBar.create(starting_at: 0, total: DailySummary.count, format: "Progress %c/%C |%b>%i| %a %e")
    DailySummary.in_batches(of: 10_000) do |relation|
      progressbar.progress += relation.update_all("fallback_clicks_count = clicks_count * (fallback_percentage::decimal * 0.01)")
    end
  end
end
