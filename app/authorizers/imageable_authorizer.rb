# frozen_string_literal: true

class ImageableAuthorizer < Perm::Authorized
  alias_method :user, :subject

  def can_view?(imageable)
    return true if user.has_role?(ENUMS::USER_ROLES::ADMINISTRATOR)
    user == imageable
  end
end
