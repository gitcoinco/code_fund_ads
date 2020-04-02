if Rails.env.production?
  DownloadAndExtractMaxmindFileJob.new.perform
else
  DownloadAndExtractMaxmindFileJob.perform_later
end
