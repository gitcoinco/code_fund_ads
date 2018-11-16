# == Schema Information
#
# Table name: creative_images
#
#  id                           :bigint(8)        not null, primary key
#  creative_id                  :bigint(8)        not null
#  active_storage_attachment_id :bigint(8)        not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#

require "test_helper"

class CreativeImageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
