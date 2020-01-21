module Authorizers
  module Creative
    def can_create_creative?
      return true if can_admin_system? || can_advertise?
      false
    end

    def can_edit_creative?(creative)
      return true if can_admin_system?
      return false unless can_manage_organization?(creative.organization)
      return true unless creative.organization.creative_approval_needed?
      !creative.active?
    end
  end
end
