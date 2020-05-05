class CreateInboundEmailFromIncomingMailboxJob < ApplicationJob
  include ActionView::Helpers::TextHelper

  queue_as :low

  def perform(action_mailbox_inbound_email_id)
    action_mailbox_inbound_email = ::ActionMailbox::InboundEmail.find(action_mailbox_inbound_email_id)
    mail = action_mailbox_inbound_email.mail

    inbound_email = InboundEmail.create \
      action_mailbox_inbound_email_id: action_mailbox_inbound_email.id,
      sender: mail.from.first,
      recipients: (mail.to.to_a + mail.cc.to_a).uniq.compact.sort,
      subject: mail.subject,
      snippet: truncate(mail.body.decoded, length: 300),
      delivered_at: (DateTime.parse(mail.raw_source.match(%r{Date: (.*)\r\n})[1]) rescue action_mailbox_inbound_email.created_at)

    return unless inbound_email.persisted?

    inbound_email.users = User.where(email: inbound_email.participant_addresses)
  end
end
