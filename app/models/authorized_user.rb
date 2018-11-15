# frozen_string_literal: true

class AuthorizedUser < Perm::Authorized
  alias_method :user, :subject

  # IMPORTANT: Authorization methods in concerns must be unique to avoid naming collisions
  include Authorizers::Roles
  include Authorizers::Images
  include Authorizers::Imageable
end
