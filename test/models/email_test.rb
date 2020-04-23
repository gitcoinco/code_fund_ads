# == Schema Information
#
# Table name: emails
#
#  id           :bigint           not null, primary key
#  content      :text             not null
#  delivered_at :datetime         not null
#  from         :string           not null
#  subject      :string           not null
#  to           :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  message_id   :string           not null
#
# Indexes
#
#  index_emails_on_message_id  (message_id) UNIQUE
#
require 'test_helper'

class EmailTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
