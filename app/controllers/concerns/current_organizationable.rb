module CurrentOrganizationable
  extend ActiveSupport::Concern

  included do
    before_action :set_current_organization
  end

  def set_current_organization
    return unless current_user
    @current_org ||= current_user&.organizations&.blank? ? set_organization : set_current_org

    session[:organization_id] = @current_org.id
  end

  private

  def set_organization
    current_user&.organization
  end

  def set_current_org
    if session[:organization_id].present? && current_user.organizations.map(&:id).include?(session[:organization_id])
      current_user&.organizations&.find_by(id: session[:organization_id])
    else
      current_user&.organizations&.last
    end
  end
end
