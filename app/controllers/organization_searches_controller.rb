class OrganizationSearchesController < ApplicationController
  before_action :authenticate_administrator!

  def create
    session[:organization_search] = OrganizationSearch.new(organization_search_params).to_gid_param
    redirect_to organizations_path
  end

  def update
    if session[:organization_search].present?
      organization_search = GlobalID.parse(session[:organization_search]).find if session[:organization_search].present?
      session[:organization_search] = OrganizationSearch.new(organization_search.to_h(params[:remove])).to_gid_param
    end
    redirect_to organizations_path
  end

  def destroy
    session[:organization_search] = OrganizationSearch.new.to_gid_param
    redirect_to organizations_path
  end

  private

  def organization_search_params
    params.require(:organization_search).permit(
      :name,
      :balance_direction
    )
  end
end
