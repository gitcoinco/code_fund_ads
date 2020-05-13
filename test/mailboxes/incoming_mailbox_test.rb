require "test_helper"

class IncomingMailboxTest < ActionMailbox::TestCase
  test "receive mail when recipient is not an administrator" do
    receive_inbound_email_from_mail \
      to: "team@codefund.io",
      from: users(:publisher).email,
      subject: "This is the subject",
      body: "This is the body"

    inbound_email = ActionMailbox::InboundEmail.last
    assert_equal "bounced", inbound_email.status
  end

  test "receive mail when sender is not an advertiser or publisher" do
    receive_inbound_email_from_mail \
      to: users(:administrator).email,
      from: "nobody@example.com",
      subject: "This is the subject",
      body: "This is the body"

    inbound_email = ActionMailbox::InboundEmail.last
    assert_equal "bounced", inbound_email.status
  end

  test "receive mail when sender is an advertiser" do
    receive_inbound_email_from_mail \
      to: users(:administrator).email,
      from: users(:advertiser).email,
      subject: "This is the subject",
      body: "This is the body"

    inbound_email = ActionMailbox::InboundEmail.last
    assert_equal "delivered", inbound_email.status
    assert inbound_email.mail.to.include?(users(:administrator).email)
    assert inbound_email.mail.from.include?(users(:advertiser).email)
  end

  test "receive mail when sender is a publisher" do
    receive_inbound_email_from_mail \
      to: users(:administrator).email,
      from: users(:publisher).email,
      subject: "This is the subject",
      body: "This is the body"

    inbound_email = ActionMailbox::InboundEmail.last
    assert_equal "delivered", inbound_email.status
    assert inbound_email.mail.to.include?(users(:administrator).email)
    assert inbound_email.mail.from.include?(users(:publisher).email)
  end

  test "receive mail when sender is a publisher but recipient does not have flag enabled" do
    user = users(:administrator)
    user.update(record_inbound_emails: false)

    receive_inbound_email_from_mail \
      to: user.email,
      from: users(:publisher).email,
      subject: "This is the subject",
      body: "This is the body"

    inbound_email = ActionMailbox::InboundEmail.last
    assert_equal "bounced", inbound_email.status
  end
end
