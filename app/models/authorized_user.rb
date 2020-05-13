class AuthorizedUser < Perm::Authorized
  alias user subject

  # Authorization methods in concerns must be unique to avoid naming collisions
  # The naming convention is: can_VERB_NOUN?
  #
  # Examples:
  #
  #   can_admin_system?
  #   can_update_image?
  #   can_view_imageable?
  #
  include Authorizers::Campaign
  include Authorizers::Comment
  include Authorizers::Creative
  include Authorizers::Email
  include Authorizers::Image
  include Authorizers::Imageable
  include Authorizers::JobPosting
  include Authorizers::Organization
  include Authorizers::Roles
  include Authorizers::Versionable
end
