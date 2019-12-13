class OrganizationUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization, except: [:create, :update]
  before_action :set_organization_user, only: [:edit, :update, :destroy]

  def index
    organization_users = @organization.organization_users.includes(:user).order(role: :asc)
    @pagy, @organization_users = pagy(organization_users)
  end

  def update
    @organization_user.update(organization_user_params)

    respond_to do |format|
      if @organization_user.save
        format.html { redirect_to organization_users_path(@organization), notice: "User's membership in the organization was successfully updated." }
        format.json { render :show, status: :ok, location: @organization_user }
      else
        format.html { render :edit }
        format.json { render json: @organization_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @organization_user = OrganizationUser.new
  end

  def create
    @organization_user = OrganizationUser.new(organization_user_params)

    respond_to do |format|
      if @organization_user.save
        format.html { redirect_to organization_users_path(@organization), notice: "User was successfully added to the organization." }
        format.json { render :show, status: :created, location: @organization_user }
      else
        format.html { render :new }
        format.json { render json: @organization_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @organization_user.destroy

    respond_to do |format|
      format.html { redirect_to organization_users_path(@organization), notice: "User was successfully removed from the organization." }
      format.json { head :no_content }
    end
  end

  private

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def set_organization_user
    @organization_user = OrganizationUser.find(params[:id])
  end

  def organization_user_params
    params.require(:organization_user).permit(:role, :user_id, :organization_id)
  end
end
