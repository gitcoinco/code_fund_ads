# == Schema Information
#
# Table name: email_templates
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  subject    :string           not null
#  body       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class EmailTemplateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
