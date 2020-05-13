# == Schema Information
#
# Table name: inbound_emails
#
#  id                              :bigint           not null, primary key
#  body                            :text
#  delivered_at                    :datetime         not null
#  recipients                      :text             default([]), not null, is an Array
#  sender                          :string           not null
#  snippet                         :text
#  subject                         :text
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  action_mailbox_inbound_email_id :bigint           not null
#
require "test_helper"

class InboundEmailTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
