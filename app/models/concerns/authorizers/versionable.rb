module Authorizers
  module Versionable
    def can_view_versionable?(versionable)
      can_edit_versionable?(versionable)
    end

    def can_edit_versionable?(versionable)
      return true if can_admin_system?
      return can_manage_organization?(versionable.organization) if versionable.try(:organization)
      return user == versionable.user if versionable.try(:user)
      false
    end
  end
end
