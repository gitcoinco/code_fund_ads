module Authorizable
  extend ActiveSupport::Concern

  included do
    helper_method :authorized_user
  end

  def authorized_user(include_true_user = false)
    @authorized_user = if include_true_user
      AuthorizedUser.new(true_user || current_user || User.new)
    else
      AuthorizedUser.new(current_user || User.new)
    end
  end
end
