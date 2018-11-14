# frozen_string_literal: true

class ImagesAuthorizer < Perm::Authorized
  alias_method :user, :subject

  def can_update?(image)
    return true if user.has_role?(ENUMS::USER_ROLES::ADMINISTRATOR)
    image.record == user
  end

  def can_destroy?(image)
    return true if user.has_role?(ENUMS::USER_ROLES::ADMINISTRATOR)
    image.record == user
  end

  def can_view_images?(imageable)
    return true if user.has_role?(ENUMS::USER_ROLES::ADMINISTRATOR)
    user == imageable
  end
end
