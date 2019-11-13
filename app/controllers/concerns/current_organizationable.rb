module CurrentOrganizationable
  extend ActiveSupport::Concern

  def current_organization
    @current_organization ||= set_current_organization
  end

  private

  def set_current_organization
    return unless current_user

    current_organization = valid_organization? ?
      set_user_organization(session[:organization_id]) :
      set_default_organization

    if params["current-organization"].present?
      current_organization = set_user_organization(params["current-organization"])
    end

    session[:organization_id] = current_organization&.id

    current_organization
  end

  def set_default_organization
    current_user&.organization
  end

  def set_user_organization(id)
    current_user&.organizations&.find_by(id: id)
  end

  def valid_organization?
    session[:organization_id].present? && current_user.organizations.map(&:id).include?(session[:organization_id])
  end
end
