module Authorizers
  module Email
    def can_view_emails?
      return true if can_admin_system?
      false
    end
  end
end
