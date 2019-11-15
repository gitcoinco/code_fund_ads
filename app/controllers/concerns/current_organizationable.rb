module CurrentOrganizationable
  extend ActiveSupport::Concern

  def current_organization
    return unless current_user

    @current_organization ||= set_current_organization
  end

  private

  def set_current_organization
    session[:organization_id] = organization&.id
    Current.organization = organization

    organization
  end

  def organization
    @organization ||= if session[:organization_id].nil?
      set_default_organization
    else
      find_organization
    end
  end

  def find_organization
    id = organization_id if valid_user_organization?(organization_id)
    Organization.find(id)
  end

  def organization_id
    return params["current-organization"] if params["current-organization"]

    if controller_name.inquiry.organizations? && params[:action] != "index"
      params[:id]
    else
      params[:organization_id] || session[:organization_id]
    end
  end

  def set_default_organization
    if current_user.organization_users.nil?
      set_legacy_organization
    else
      default_organization_by_role
    end
  end

  def set_legacy_organization
    current_user&.organization
  end

  def default_organization_by_role
    current_user.organizations_as_owner.first ||
      current_user.organizations_as_administrator.first ||
      current_user.organizations_as_member.first
  end

  def valid_user_organization?(org_id)
    return true if authorized_user.can_admin_system?

    current_user.organizations.map(&:id).include?(org_id.to_i)
  end
end
