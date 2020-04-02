class UserPasswordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update]

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_password_params)
        @user.send_password_change_notification

        format.html { redirect_to user_path("me"), notice: "Password was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_password_params
    params.require(:user).permit(
      :password,
      :password_confirmation
    )
  end
end
