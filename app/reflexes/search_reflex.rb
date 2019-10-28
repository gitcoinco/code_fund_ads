# frozen_string_literal: true

class SearchReflex < ApplicationReflex
  def perform(query = "")
    @search_query = query
    @search_results = if authorized_user.can_admin_system?
      {
        users: User.search_name(query).or(User.search_email(query)).limit(5),
        properties: Property.search_name(query).limit(5),
        campaigns: Campaign.search_name(query).limit(5),
        organizations: Organization.search_name(query).limit(5),
      }
    else
      {
        users: [],
        properties: [],
        campaigns: [],
        organizations: [],
      }
    end
  end
end
