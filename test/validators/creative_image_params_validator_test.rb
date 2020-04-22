require "test_helper"

class CreativeImageParamsValidatorTest < ActiveSupport::TestCase
  test "should return ActiveModel::Errors object" do
    validation = CreativeImageParamsValidator.new(ActionController::Parameters.new({icon_blob_id: 1}))
    assert validation.errors.is_a? ActiveModel::Errors
  end

  test "should be invalid with missing image params" do
    validation = CreativeImageParamsValidator.new(ActionController::Parameters.new({icon_blob_id: 1, small_blob_id: 2}))
    assert_not validation.valid?
    assert_equal [:large_image, :wide_image], validation.errors.keys
    assert_equal ["Large image must be selected", "Wide image must be selected"], validation.errors.full_messages
  end

  test "should be valid with correct image params" do
    validation = CreativeImageParamsValidator.new(
      ActionController::Parameters.new({icon_blob_id: 1, small_blob_id: 2, wide_blob_id: 3, large_blob_id: 4})
    )
    assert validation.valid?
    assert validation.errors.empty?
  end
end
