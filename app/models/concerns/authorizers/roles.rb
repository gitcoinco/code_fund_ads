# frozen_string_literal: true

module Authorizers
  module Roles
    def can_admin_system?
      user.has_role?(ENUMS::USER_ROLES::ADMINISTRATOR)
    end
  end
end
