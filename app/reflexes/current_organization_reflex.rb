class CurrentOrganizationReflex < ApplicationReflex
  def change
    organization_id = element.attributes[:value].to_i
    session[:u_organization_id] = organization_id
  end
end
