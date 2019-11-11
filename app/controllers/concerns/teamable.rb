module Teamable
  extend ActiveSupport::Concern

  included do
    before_action :set_current_organization
  end

  private

  def set_current_organization
    return unless current_user

    @team = current_user&.organizations&.blank? ? set_organization : set_team

    session[:organization_id] = @team.id
  end

  def set_organization
    current_user&.organization
  end

  def set_team
    session[:organization_id].present? ?
      current_user&.organizations&.find_by(id: session[:organization_id]) :
      current_user&.organizations&.first
  end
end
