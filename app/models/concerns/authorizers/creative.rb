module Authorizers
  module Creative
    def can_create_creative?
      return true if can_admin_system? || can_advertise?
      false
    end

    def can_edit_creative?(creative)
      return true if can_edit_creatives_without_approval?(creative.organization)
      !creative.active?
    end
  end
end
