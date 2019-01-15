namespace :jobs do
  desc "Import jobs from RemoteOK.io"
  task import_remoteok: :environment do
    tags = %w[dev javascript ruby go python c dotnet elixir]
    ImportRemoteokJobsJob.new.perform(*tags)
    puts "There are #{JobPosting.count} jobs"
  end
end
