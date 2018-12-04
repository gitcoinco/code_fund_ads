class CreativeSearchesController < ApplicationController
  before_action :authenticate_user!

  def create
    session[:creative_search] = CreativeSearch.new(creative_search_params).to_gid_param
    redirect_to creatives_path
  end

  def update
    if session[:creative_search].present?
      creative_search = GlobalID.parse(session[:creative_search]).find if session[:creative_search].present?
      session[:creative_search] = CreativeSearch.new(creative_search.to_h(params[:remove])).to_gid_param
    end
    redirect_to creatives_path
  end

  def destroy
    session[:creative_search] = CreativeSearch.new.to_gid_param
    redirect_to creatives_path
  end

  private

  def creative_search_params
    params.require(:creative_search).permit(
      :name,
      :user,
      :user_id
    )
  end
end
