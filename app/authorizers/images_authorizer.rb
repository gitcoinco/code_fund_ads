class ImagesAuthorizer < Perm::Authorized
  alias_method :user, :subject

  def can_update?(image)
    return true if user.has_role?(ENUMS::USER_ROLES::ADMINISTRATOR)
    image.record == user
  end
end
