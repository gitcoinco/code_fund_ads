module Authorizers
  module Organization
    def can_edit_organization?(organization)
      return true if can_admin_system?
      OrganizationUser.where(
        organization: organization,
        user: user,
        role: [ENUMS::ORGANIZATION_ROLES::ADMINISTRATOR, ENUMS::ORGANIZATION_ROLES::OWNER]
      ).exists?
    end
  end
end
