class UserPropertiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: :index

  def index
    properties = Property.where(user: @user).order_by_status
    @pagy, @properties = pagy(properties)
  end

  private

  def set_user
    @user = if authorized_user.can_admin_system?
      User.find(params[:user_id])
    else
      current_user
    end
  end
end
