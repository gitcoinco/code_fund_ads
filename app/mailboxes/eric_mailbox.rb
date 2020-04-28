class EricMailbox < ApplicationMailbox
  before_processing :require_user

  def process
    Email.create from_address: mail.from.first, 
                 subject: mail.subject, 
                 content: mail.body.decoded,
                 message_id: inbound_email.message_id,
                 to_addresses: mail.to.to_a.sort,
                 cc_addresses: mail.cc.to_a.sort,
                 delivered_at: (DateTime.parse(mail.raw_source.match(%r{Date: (.*)\r\n})[1]) rescue inbound_email.created_at)
  end

  private

  def require_user
    @user = User.find_by(email: mail.from)
    return bounced! unless @user
  end
end
