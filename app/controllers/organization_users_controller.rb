class OrganizationUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization
  before_action :set_organization_user, except: :index

  def index
    organization_users = @organization.organization_users.order(role: :asc)
    @pagy, @organization_users = pagy(organization_users)
  end

  def update
    @organization_user.update(organization_user_params)

    respond_to do |format|
      if @organization_user.save
        format.html { redirect_to organization_users_path, notice: "Organization user was successfully updated." }
        format.json { render :show, status: :ok, location: @organization_user }
      else
        format.html { render :edit }
        format.json { render json: @organization_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @organization_user.destroy

    respond_to do |format|
      format.html { redirect_to organization_users_path, notice: "User was successfully removed from the organization." }
      format.json { head :no_content }
    end
  end

  private

  def set_organization
    @organization = Current.organization
  end

  def set_organization_user
    @organization_user = OrganizationUser.find(params[:id])
  end

  def organization_user_params
    params.require(:organization_user).permit(:role)
  end
end
