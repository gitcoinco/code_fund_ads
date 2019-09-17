module Authorizable
  extend ActiveSupport::Concern

  included do
    helper_method :authorized_user
  end

  def authorized_user
    @authorized_user ||= AuthorizedUser.new(current_user || User.new)
  end
end
