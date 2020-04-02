if Rails.env.production? || ENV["CI"] == "true"
  DownloadAndExtractMaxmindFileJob.perform_now
else
  DownloadAndExtractMaxmindFileJob.perform_later
end
