module Authorizers
  module Roles
    def can_admin_system?
      user.has_role?(ENUMS::USER_ROLES::ADMINISTRATOR)
    end

    def can_advertise?
      user.has_any_roles?(ENUMS::USER_ROLES::ADVERTISER, ENUMS::USER_ROLES::ADMINISTRATOR)
    end

    def can_publish?
      user.has_any_roles?(ENUMS::USER_ROLES::PUBLISHER, ENUMS::USER_ROLES::ADMINISTRATOR)
    end

    def can_advertise_and_publish?
      user.has_all_roles?(ENUMS::USER_ROLES::PUBLISHER, ENUMS::USER_ROLES::ADMINISTRATOR)
    end
  end
end
