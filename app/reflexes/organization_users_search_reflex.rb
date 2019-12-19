class OrganizationUsersSearchReflex < ApplicationReflex
  def perform(query = "")
    return unless query.size > 2
    session[:organization_user_search_result] = User.find_by(email: query.downcase)
  end
end
