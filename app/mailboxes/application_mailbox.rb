class ApplicationMailbox < ActionMailbox::Base
  routing /^eric@/i => :eric
  routing :all => :incoming
  
  def self.receive(inbound_email)
    binding.pry
    Rails.logger.debug("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    super(inbound_email)
  end
end
