class ImpersonationsController < ApplicationController
  before_action :authenticate_administrator!, only: [:update]
  before_action :clear_searches
  after_action :clear_session_organization_id

  def update
    user = User.find(params[:user_id])
    impersonate_user(user)
    redirect_to user_path(user)
  end

  def destroy
    stop_impersonating_user
    redirect_to users_path
  end

  private

  def clear_session_organization_id
    session[:organization_id] = nil
  end
end
