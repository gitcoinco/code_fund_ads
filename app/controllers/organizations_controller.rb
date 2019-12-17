class OrganizationsController < ApplicationController
  include Sortable
  include Scopable

  before_action :authenticate_administrator!, except: [:show]
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  def index
    organizations = scope_list(Organization).order(order_by)
    max = (organizations.count / Pagy::VARS[:items].to_f).ceil
    @pagy, @organizations = pagy(organizations, page: current_page(max: max))
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: t("organizations.create.success") }
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
        format.html { redirect_to @organization, notice: t("organizations.update.success") }
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
        format.html { redirect_to organizations_url, notice: t("organizations.destroy.success") }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to organizations_url, alert: t("organizations.destroy.failure") }
        format.json { head :no_content }
      end
    end
  end

  private

  def set_organization
    @organization ||= Current.organization
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
      updated_at
    ]
  end
end
