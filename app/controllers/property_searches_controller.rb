class PropertySearchesController < ApplicationController
  before_action :authenticate_user!

  def create
    session[:property_search] = PropertySearch.new(property_search_params).to_gid_param
    redirect_to properties_path
  end

  def destroy
    session[:property_search] = PropertySearch.new.to_gid_param
    redirect_to properties_path
  end

  private

  def property_search_params
    params.require(:property_search).permit(
      :name,
      :url,
      :user,
      :user_id,
      ad_templates: [],
      keywords: [],
      languages: [],
      property_types: [],
      statuses: [],
    )
  end
end
