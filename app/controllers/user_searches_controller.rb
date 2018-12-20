class UserSearchesController < ApplicationController
  before_action :authenticate_user!

  def create
    session[:user_search] = UserSearch.new(user_search_params).to_gid_param
    redirect_to users_path
  end

  def update
    if session[:user_search].present?
      user_search = GlobalID.parse(session[:user_search]).find if session[:user_search].present?
      session[:user_search] = UserSearch.new(user_search.to_h(params[:remove])).to_gid_param
    end
    redirect_to users_path
  end

  def destroy
    session[:user_search] = UserSearch.new.to_gid_param
    redirect_to users_path
  end

  private

  def user_search_params
    params.require(:user_search).permit(
      :organization_id,
      :email,
      :name,
      roles: [],
    )
  end
end
