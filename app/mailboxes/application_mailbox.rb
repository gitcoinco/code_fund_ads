class ApplicationMailbox < ActionMailbox::Base
  routing :all => :incoming
end
