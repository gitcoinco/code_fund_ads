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

    refute Email.find_by(action_mailbox_inbound_email_id: inbound_email.id)
  end

  test "receive mail when sender is not an advertiser or publisher" do
    receive_inbound_email_from_mail \
      to: users(:administrator).email,
      from: "nobody@example.com",
      subject: "This is the subject",
      body: "This is the body"

    inbound_email = ActionMailbox::InboundEmail.last
    assert_equal "bounced", inbound_email.status

    refute Email.find_by(action_mailbox_inbound_email_id: inbound_email.id)
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

    email = Email.find_by(action_mailbox_inbound_email_id: inbound_email.id)
    assert_equal ENUMS::EMAIL_DIRECTIONS::INBOUND, email.direction
    assert_instance_of ActionText::RichText, email.body
    assert_equal "This is the body", email.snippet
    assert_equal "This is the subject", email.subject
    assert_equal [users(:administrator).email], email.recipients
    assert_equal users(:advertiser).email, email.sender
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

    email = Email.find_by(action_mailbox_inbound_email_id: inbound_email.id)
    assert_equal ENUMS::EMAIL_DIRECTIONS::INBOUND, email.direction
    assert_instance_of ActionText::RichText, email.body
    assert_equal "This is the body", email.snippet
    assert_equal "This is the subject", email.subject
    assert_equal [users(:administrator).email], email.recipients
    assert_equal users(:publisher).email, email.sender
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

    refute Email.find_by(action_mailbox_inbound_email_id: inbound_email.id)
  end

  test "send mail when recipient is a publisher" do
    receive_inbound_email_from_mail \
      to: users(:publisher).email,
      from: users(:administrator).email,
      subject: "This is the subject",
      body: "This is the body"

    inbound_email = ActionMailbox::InboundEmail.last
    assert_equal "delivered", inbound_email.status
    assert inbound_email.mail.to.include?(users(:publisher).email)
    assert inbound_email.mail.from.include?(users(:administrator).email)

    email = Email.find_by(action_mailbox_inbound_email_id: inbound_email.id)
    assert_equal ENUMS::EMAIL_DIRECTIONS::OUTBOUND, email.direction
    assert_instance_of ActionText::RichText, email.body
    assert_equal "This is the body", email.snippet
    assert_equal "This is the subject", email.subject
    assert_equal [users(:publisher).email], email.recipients
    assert_equal users(:administrator).email, email.sender
  end

  test "send mail when recipient is an advertiser" do
    advertiser = users(:advertiser)
    administrator = users(:administrator)

    receive_inbound_email_from_mail \
      to: advertiser.email,
      from: administrator.email,
      subject: "This is the subject",
      body: "This is the body"

    inbound_email = ActionMailbox::InboundEmail.last
    assert_equal "delivered", inbound_email.status
    assert inbound_email.mail.to.include?(advertiser.email)
    assert inbound_email.mail.from.include?(administrator.email)

    email = Email.find_by(action_mailbox_inbound_email_id: inbound_email.id)
    assert_equal "outbound", ENUMS::EMAIL_DIRECTIONS::OUTBOUND
    assert_instance_of ActionText::RichText, email.body
    assert_equal "This is the body", email.snippet
    assert_equal "This is the subject", email.subject
    assert_equal [advertiser.email], email.recipients
    assert_equal administrator.email, email.sender
    assert email.users.include?(advertiser)
    assert email.users.include?(administrator)
  end

  test "receive mail when recipient is a publisher but sender does not have flag enabled" do
    user = users(:administrator)
    user.update(record_inbound_emails: false)

    receive_inbound_email_from_mail \
      to: users(:advertiser).email,
      from: user.email,
      subject: "This is the subject",
      body: "This is the body"

    inbound_email = ActionMailbox::InboundEmail.last
    assert_equal "bounced", inbound_email.status

    refute Email.find_by(action_mailbox_inbound_email_id: inbound_email.id)
  end

  test "receive mail when sender and recipients are the only participants" do
    admin_1 = users(:administrator)
    admin_2 = users(:administrator_2)

    receive_inbound_email_from_mail \
      to: admin_2.email,
      from: admin_1.email,
      subject: "This is the subject",
      body: "This is the body"

    inbound_email = ActionMailbox::InboundEmail.last
    assert_equal "bounced", inbound_email.status

    refute Email.find_by(action_mailbox_inbound_email_id: inbound_email.id)
  end
end
