class IncomingMailbox < ApplicationMailbox
  def process
    bounced!
  end
end
