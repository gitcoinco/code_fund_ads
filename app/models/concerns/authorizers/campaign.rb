module Authorizers
  module Campaign
    def can_assign_property_to_campaign?(property, campaign)
      return false unless campaign.fallback?
      return true if can_admin_system?
      property.user_id == campaign.user_id
    end
  end
end
