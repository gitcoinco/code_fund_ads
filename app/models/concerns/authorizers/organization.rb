module Authorizers
  module Organization
    def can_edit_organization?(organization)
      return true if can_admin_system?
      organization.users.include?(user)
    end

    def can_manage_organization?(organization)
      # The distinction between this and can_edit_organization? is
      # this is intended to be used in other authorizers, since
      # we do not check for can_admin_system?
      organization.users.include?(user)
    end

    def can_edit_organization_users?(organization)
      return true if can_admin_system?
      organization.administrators.include?(user)
    end

    def can_edit_creatives_without_approval?(organization)
      return true if can_admin_system?
      return false unless can_manage_organization?(organization)
      !organization.creative_approval_needed?
    end
  end
end
