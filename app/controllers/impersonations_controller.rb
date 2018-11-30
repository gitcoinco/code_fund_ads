class ImpersonationsController < ApplicationController
  before_action :authenticate_administrator!, only: [:update]

  def update
    user = User.find(params[:user_id])
    impersonate_user(user)
    redirect_to user_path(user)
  end

  def destroy
    stop_impersonating_user
    redirect_to users_path
  end
end
