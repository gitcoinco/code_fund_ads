# frozen_string_literal: true

class UsersAuthorizer < Perm::Authorized
  alias_method :user, :subject

  def can_admin_system?
    user.has_role?(ENUMS::USER_ROLES::ADMINISTRATOR)
  end
end
