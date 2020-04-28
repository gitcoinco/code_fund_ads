# == Schema Information
#
# Table name: emails
#
#  id           :bigint           not null, primary key
#  cc_addresses :text             default([]), is an Array
#  content      :text             not null
#  delivered_at :datetime         not null
#  from_address :string           not null
#  subject      :string           not null
#  to_addresses :text             default([]), is an Array
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  message_id   :string           not null
#
# Indexes
#
#  index_emails_on_cc_addresses  (cc_addresses) USING gin
#  index_emails_on_from_address  (from_address)
#  index_emails_on_message_id    (message_id) UNIQUE
#  index_emails_on_to_addresses  (to_addresses) USING gin
#
require 'test_helper'

class EmailTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
