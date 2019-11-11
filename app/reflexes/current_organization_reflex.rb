class CurrentOrganizationReflex < ApplicationReflex
  def change
    binding.pry
    organization_id = element.attributes[:value].to_i
    session[:organization_id] = organization_id
  end
end
