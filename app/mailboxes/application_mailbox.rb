class ApplicationMailbox < ActionMailbox::Base
  routing /^eric@/i => :eric
  routing :all => :incoming
end
