module Organization::Currentable
  extend ActiveSupport::Concern

  def current_organization
    return unless current_user

    @current_organization ||= set_current_organization
  end

  private

  def set_current_organization
    session[:organization_id] = org&.id
    Current.organization = org

    org
  end

  def org
    @org ||= if session[:organization_id].nil?
      set_default_organization
    else
      valid_user_organization?(organization_id) ? Organization.find(organization_id) : set_default_organization
    end
  end

  def organization_id
    @organization_id ||= find_organization_id
  end

  def find_organization_id
    return params["current-organization"] if params["current-organization"]

    if controller_name.inquiry.organizations? && !%w[index new create].include?(action_name)
      params[:id]
    else
      session[:organization_id] || params[:organization_id]
    end
  end

  def set_default_organization
    if current_user.organization_users.nil?
      current_user&.organization
    else
      current_user.default_organization
    end
  end

  def valid_user_organization?(org_id)
    return true if authorized_user.can_admin_system?

    current_user.organizations.where(id: org_id).exists?
  end
end
