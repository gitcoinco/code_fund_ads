class OrganizationUsersReflex < ApplicationReflex
  def member(value)
    session[:organization_users_new_member_type] = value
  end
end
