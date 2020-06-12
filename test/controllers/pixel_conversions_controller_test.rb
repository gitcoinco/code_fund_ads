require "test_helper"

class PixelConversionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pixel = pixels(:one)
    @impression = premium_impression
    @impression.update(organization: @pixel.organization)
  end

  test "should create pixel conversion on POST" do
    perform_enqueued_jobs do
      post pixel_conversions_path(@pixel, @impression), params: {
        test: true,
        metadata: {"foo" => "bar"}.to_json
      }
    end
    assert status == 202
    assert_performed_jobs 1
    conversion = @pixel.pixel_conversions.find_by(pixel: @pixel, impression: @impression)
    assert conversion
    assert conversion.test?
    assert conversion.metadata["foo"] = "bar"
  end

  test "should not create pixel conversion when tracking_id is invalid" do
    perform_enqueued_jobs do
      post pixel_conversions_path(@pixel, SecureRandom.uuid), params: {test: true}
    end
    assert status == 202
    assert_performed_jobs 1
    conversion = @pixel.pixel_conversions.find_by(pixel: @pixel, impression: @impression)
    refute conversion
  end

  test "should not create pixel conversion when conversion already exists" do
    @pixel.record_conversion(@impression.id, test: true)
    assert PixelConversion.where(pixel: @pixel, impression: @impression).count == 1
    perform_enqueued_jobs do
      post pixel_conversions_path(@pixel, @impression), params: {
        test: true
      }
    end
    assert status == 202
    assert_performed_jobs 1
    assert PixelConversion.where(pixel: @pixel, impression: @impression).count == 1
  end
end
