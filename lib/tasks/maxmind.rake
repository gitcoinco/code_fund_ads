namespace :code_fund do
  namespace :maxmind do
    desc "Download the MaxMind GeoLite2-City.tar.gz file."
    task download: :environment do
      DownloadAndExtractMaxmindFileJob.new.download
    end
  end
end
