class OrganizationsController < ApplicationController
  include Sortable

  before_action :authenticate_administrator!
  before_action :set_organization_search, only: [:index]
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  def index
    organizations = Organization.order(order_by)
    organizations = @organization_search.apply(organizations)
    @pagy, @organizations = pagy(organizations)
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: "Organization was successfully created." }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: "Organization was successfully updated." }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @organization.users.empty?
      @organization.destroy
      respond_to do |format|
        format.html { redirect_to organizations_url, notice: "Organization was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to organizations_url, alert: "We are unable to delete an organization that has users" }
        format.json { head :no_content }
      end
    end
  end

  private

  def set_organization_search
    clear_searches except: :organization_search
    @organization_search = GlobalID.parse(session[:organization_search]).find if session[:organization_search].present?
    @organization_search ||= OrganizationSearch.new
  end

  def set_organization
    @organization = if authorized_user.can_admin_system?
      Organization.find(params[:id])
    else
      current_user.organization
    end
  end

  def organization_params
    params.require(:organization).permit(
      :name
    )
  end

  def sortable_columns
    %w[
      name
      balance_cents
      created_at
    ]
  end
end
