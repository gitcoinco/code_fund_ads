class IncomingMailbox < ApplicationMailbox
  def process
    bounce!
  end
end
