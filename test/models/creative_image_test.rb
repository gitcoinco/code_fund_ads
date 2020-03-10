# == Schema Information
#
# Table name: creative_images
#
#  id                           :bigint           not null, primary key
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  active_storage_attachment_id :bigint           not null
#  creative_id                  :bigint           not null
#
# Indexes
#
#  index_creative_images_on_active_storage_attachment_id  (active_storage_attachment_id)
#  index_creative_images_on_creative_id                   (creative_id)
#

require "test_helper"

class CreativeImageTest < ActiveSupport::TestCase
  def setup
    creative = creatives(:premium)
    @creative_image = creative.add_image! attach_large_image!(creative.organization)
  end

  test "creative relationship" do
    assert @creative_image.creative
  end

  test "image relationship" do
    assert @creative_image.image
  end

  test "organization relationship" do
    assert @creative_image.organization
  end

  test "standard? correctly detects standard image formats" do
    @creative_image.image.stubs(metadata: {format: "large"})
    assert @creative_image.standard?
  end

  test "standard? correctly detects non-standard image formats" do
    @creative_image.image.stubs(metadata: {format: "chonky"})
    assert_not @creative_image.standard?
  end
end
