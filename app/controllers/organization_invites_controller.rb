class OrganizationInvitesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization

  def create
    user = User.invite!(user_invite_params.merge!(roles: Array(ENUMS::USER_ROLES::ADVERTISER)))
    organization_user = OrganizationUser.new(
      user: user,
      organization_id: organization_user_invite_params[:organization_id],
      role: organization_user_invite_params[:organization_role],
    )

    respond_to do |format|
      if organization_user.save
        format.html { redirect_to organization_users_path(@organization), notice: "User was successfully invited to the organization." }
        format.json { render :show, status: :created, location: organization_user }
      else
        format.html { render :new }
        format.json { render json: organization_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_organization
    @organization = Current.organization
  end

  def organization_user_invite_params
    params.require(:organization_invite).permit(:organization_id, :organization_role)
  end

  def user_invite_params
    params.require(:organization_invite).permit(:first_name, :last_name, :email)
  end
end
