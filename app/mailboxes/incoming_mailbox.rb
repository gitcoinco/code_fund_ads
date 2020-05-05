class IncomingMailbox < ApplicationMailbox
  before_processing :verify_participants

  def process
    CreateInboundEmailFromIncomingMailboxJob.perform_later(inbound_email.id)
  end

  private

  # Only allow inbound emails with the following criteria:
  # 1. Sender must be either a publisher or advertiser
  # 2. Recipient must be a CodeFund administrator
  # 3. Recipient must have the 'record_inbound_emails' flag set to true
  def verify_participants
    return bounced! unless User.administrators.find_by(email: mail.to)&.record_inbound_emails?
    return bounced! if !User.advertisers.exists?(email: mail.from) && !User.publishers.exists?(email: mail.from)
  end
end