# == Schema Information
#
# Table name: emails
#
#  id                              :bigint           not null, primary key
#  body                            :text
#  delivered_at                    :datetime         not null
#  delivered_at_date               :date             not null
#  direction                       :string           default("inbound"), not null
#  in_reply_to                     :string
#  recipients                      :string           default([]), not null, is an Array
#  sender                          :string
#  snippet                         :text
#  subject                         :text
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  action_mailbox_inbound_email_id :bigint           not null
#  message_id                      :string
#  parent_id                       :bigint
#
# Indexes
#
#  index_emails_on_delivered_at_date  (delivered_at_date)
#  index_emails_on_delivered_at_hour  (date_trunc('hour'::text, delivered_at))
#  index_emails_on_parent_id          (parent_id)
#  index_emails_on_recipients         (recipients) USING gin
#  index_emails_on_sender             (sender)
#
require "test_helper"

class EmailTest < ActiveSupport::TestCase
  setup do
    inbound_email = create_inbound_email_from_fixture("email.eml")
    delivered_at = DateTime.now
    @user = users(:administrator)
    @email = Email.create(
      action_mailbox_inbound_email_id: inbound_email.id,
      sender: inbound_email.mail.from.first,
      recipients: (inbound_email.mail.to.to_a + inbound_email.mail.cc.to_a).uniq.compact.sort,
      message_id: inbound_email.mail.message_id,
      subject: inbound_email.mail.subject,
      body: inbound_email.mail.text_part.body.decoded,
      delivered_at: delivered_at,
      delivered_at_date: delivered_at
    )
    @email_user = EmailUser.create(user: @user, email: @email)
  end

  test "#read_by?" do
    assert_not @email.read_by?(@user)
    @email_user.update!(read_at: 1.day.ago)
    assert @email.read_by?(@user)
  end

  test "#mark_read_for_user!" do
    @email.mark_read_for_user!(@user)
    @email_user.reload
    assert_not_nil @email_user.read_at
  end

  test "#mark_unread_for_user!" do
    @email_user.update!(read_at: 1.day.ago)
    @email.mark_unread_for_user!(@user)
    @email_user.reload
    assert_nil @email_user.read_at
  end
end
