# frozen_string_literal: true

class AuthorizedUser < Perm::Authorized
  alias_method :user, :subject

  # Authorization methods in concerns must be unique to avoid naming collisions
  # The naming convention is: can_VERB_NOUN?
  #
  # Examples:
  #
  #   can_admin_system?
  #   can_update_image?
  #   can_view_imageable?
  #
  include Authorizers::Roles
  include Authorizers::Images
  include Authorizers::Imageable
end
