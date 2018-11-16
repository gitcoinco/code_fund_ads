class UserSearchesController < ApplicationController
  before_action :authenticate_user!

  def create
    session[:user_search] = UserSearch.new(user_search_params).to_gid_param
    redirect_to users_path
  end

  def destroy
    session[:user_search] = UserSearch.new.to_gid_param
    redirect_to users_path
  end

  private

  def user_search_params
    params.require(:user_search).permit(
      :company_name,
      :email,
      :name,
      roles: [],
    )
  end
end
