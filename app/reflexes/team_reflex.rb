class TeamReflex < ApplicationReflex
  def change
    session[:organization_id] = element.attributes[:value].to_i
  end
end
