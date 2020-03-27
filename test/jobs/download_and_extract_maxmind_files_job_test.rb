require "test_helper"

class DownloadAndExtractMaxmindFilesJobTest < ActiveJob::TestCase
  setup do
    @job = DownloadAndExtractMaxmindFileJob.new
  end

  test "download" do
    stub_request(:get, "download.maxmind.com")
    request = @job.download

    assert request
    assert_equal "OK", request.message
  end
end
