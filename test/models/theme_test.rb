# frozen_string_literal: true

# == Schema Information
#
# Table name: themes
#
#  id          :bigint(8)        not null, primary key
#  template_id :bigint(8)        not null
#  name        :string           not null
#  description :text             not null
#  css         :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require "test_helper"

class ThemeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
