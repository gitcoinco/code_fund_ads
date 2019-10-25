# frozen_string_literal: true

class SearchReflex < ApplicationReflex
  def perform(query = "")
    @searcy_query = query
    @search_results = {
      users: User.search_name(query).or(User.search_email(query)).limit(5),
      properties: Property.search_name(query).limit(5),
      campaigns: Campaign.search_name(query).limit(5),
      organizations: Organization.search_name(query).limit(5),
    }
  end
end
