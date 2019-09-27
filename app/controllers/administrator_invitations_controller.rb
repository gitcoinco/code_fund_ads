class AdministratorInvitationsController < ApplicationController
  before_action :authenticate_administrator!
  before_action :set_user

  # PUT /admin_invitations/:id
  # PATCH /admin_invitations/:id
  def update
    if !@user.accepted_or_not_invited?
      @user.invite!
      flash[:success] = t("devise.invitations.send_instructions", email: @user.email)
    else
      flash[:success] = t("devise.invitations.not_sent", email: @user.email)
    end

    redirect_to user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
