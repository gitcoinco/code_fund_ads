# == Schema Information
#
# Table name: pixels
#
#  id              :uuid             not null, primary key
#  description     :text
#  name            :string           not null
#  value_cents     :integer          default(0), not null
#  value_currency  :string           default("USD"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_pixels_on_organization_id  (organization_id)
#  index_pixels_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class PixelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
