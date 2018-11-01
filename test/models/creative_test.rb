# frozen_string_literal: true

# == Schema Information
#
# Table name: creatives
#
#  user_id     :uuid
#  id          :uuid             not null, primary key
#  name        :string(255)
#  body        :string(255)
#  inserted_at :datetime         not null
#  updated_at  :datetime         not null
#  headline    :string(255)
#

require "test_helper"

class CreativeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
