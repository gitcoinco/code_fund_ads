# == Schema Information
#
# Table name: templates
#
#  id          :uuid             not null, primary key
#  name        :string(255)
#  slug        :string(255)
#  description :text
#  body        :text
#  inserted_at :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class TemplateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
