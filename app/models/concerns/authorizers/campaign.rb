module Authorizers
  module Campaign
    def can_assign_property_to_campaign?(property, campaign)
      return false unless campaign.fallback?
      return true if can_admin_system?
      false
    end

    def can_edit_campaign?(campaign)
      return true if can_admin_system?
      can_manage_organization? campaign.organization
    end

    def can_update_split_experiment?(campaign)
      return true if can_admin_system?
      can_manage_organization? campaign.organization
    end

    def can_destroy_split_experiment?(campaign)
      return true if can_admin_system?
      can_manage_organization? campaign.organization
    end

    def can_activate_campaign?(campaign)
      return true if can_admin_system?
      campaign.paused? && can_manage_organization?(campaign.organization)
    end

    def can_pause_campaign?(campaign)
      return false unless campaign.active?
      return true if can_admin_system?
      can_manage_organization? campaign.organization
    end
  end
end
