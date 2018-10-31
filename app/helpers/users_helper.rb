# frozen_string_literal: true

module UsersHelper
  def user_roles_for_select
    ENUMS::USER_ROLES.values
  end
end
