require "test_helper"

class CreateImpressionJobTest < ActiveJob::TestCase
  setup do
    @campaign = campaigns(:premium)
    @creative = creatives(:premium)
    @property = properties(:website)
  end

  test "creates impression" do
    assert_difference "Impression.count", 1 do
      CreateImpressionJob.perform_now(
        Impression.count + 1,
        @campaign.id,
        @property.id,
        @creative.id,
        "default",
        "light",
        "127.0.0.1",
        "US",
        "test",
        Time.current.to_s
      )
    end
  end

  test "no user-agent" do
    assert_no_difference "Impression.count" do
      CreateImpressionJob.perform_now(
        Impression.count + 1,
        @campaign.id,
        @property.id,
        @creative.id,
        "default",
        "light",
        "127.0.0.1",
        "US",
        nil,
        Time.current.to_s
      )
    end
  end

  test "campaign not found" do
    assert_no_difference "Impression.count" do
      CreateImpressionJob.perform_now(
        Impression.count + 1,
        0,
        @property.id,
        @creative.id,
        "default",
        "light",
        "127.0.0.1",
        "US",
        nil,
        Time.current.to_s
      )
    end
  end

  test "property not found" do
    assert_no_difference "Impression.count" do
      CreateImpressionJob.perform_now(
        Impression.count + 1,
        @campaign.id,
        0,
        @creative.id,
        "default",
        "light",
        "127.0.0.1",
        "US",
        nil,
        Time.current.to_s
      )
    end
  end
end
