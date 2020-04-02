if Rails.env.production? || ENV["CI"] == "true"
  DownloadAndExtractMaxmindFileJob.new.perform
else
  DownloadAndExtractMaxmindFileJob.perform_later
end
