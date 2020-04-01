require "test_helper"

class DownloadAndExtractMaxmindFilesJobTest < ActiveJob::TestCase
  test "download" do
    stub_request(:get, /download\.maxmind\.com/).to_return(status: 200)
    DownloadAndExtractMaxmindFileJob.perform_now
  end
end
