DownloadAndExtractMaxmindFileJob.perform_now if Rails.env.production? || ENV["CI"] == "true"
