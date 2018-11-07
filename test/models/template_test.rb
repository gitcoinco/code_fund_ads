# frozen_string_literal: true

# == Schema Information
#
# Table name: templates
#
#  id          :bigint(8)        not null, primary key
#  name        :string           not null
#  description :text             not null
#  html        :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require "test_helper"

class TemplateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
