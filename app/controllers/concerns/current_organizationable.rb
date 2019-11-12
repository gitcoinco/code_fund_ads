module CurrentOrganizationable
  extend ActiveSupport::Concern

  def current_organization
    @current_organization ||= set_current_organization
  end

  private

  def set_current_organization
    return unless current_user

    current_organization = valid_organization? ?
      set_user_organization(session[:u_organization_id]) :
      set_default_organization

    if params[:organization_id].present?
      binding.pry
      current_organization = set_user_organization(params[:u_organization_id])
    end

    session[:u_organization_id] = current_organization&.id

    current_organization
  end

  def set_default_organization
    current_user&.organization
  end

  def set_user_organization(id)
    current_user&.organizations&.find_by(id: id)
  end

  def valid_organization?
    session[:u_organization_id].present? && current_user.organizations.map(&:id).include?(session[:u_organization_id])
  end
end

# module CurrentOrganizationable
#   extend ActiveSupport::Concern

#   included do
#     before_action :set_current_organization
#   end

#   def set_current_organization
#     # ActionCable.server.remote_connections.where(ids: {true_user_id: true_user.id, current_user_id: current_user.id, session_id: session.id}).disconnect
#     return unless current_user
#     return unless @stimulus_reflex

#     if session[:u_organization_id] != team.id
#       session[:u_organization_id] = team.id
#       cookies.delete :coid
#       cookies.encrypted[:coid] = team.id
#     end
#   end

#   private

#   def team
#     @team ||= current_user&.organizations&.blank? ? set_organization : set_current_org
#   end

#   def set_organization
#     current_user&.organization
#   end

#   def set_current_org
#     if session[:u_organization_id].present? && current_user.organizations.map(&:id).include?(session[:u_organization_id])
#       current_user&.organizations&.find_by(id: session[:u_organization_id])
#     else
#       current_user&.organizations&.last
#     end
#   end
# end
