module Authorizers
  module Creative
    def can_create_creative?
      return true if can_admin_system? || can_advertise?
      false
    end

    def can_edit_creative?(creative)
      return true if can_admin_system?
      creative.user == user && !creative.locked?
    end
  end
end
