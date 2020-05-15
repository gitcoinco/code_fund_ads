class OrganizationsController < ApplicationController
  include Sortable
  include Scopable

  before_action :authenticate_administrator!, except: [:show]
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  def index
    organizations = scope_list(Organization).order(order_by)
    @pagy, @organizations = pagy(organizations, page: @page)
  end

  def show
    payload = {
      resource: {
        dashboard: ENV["METABASE_ADVERTISER_DASHBOARD_ID"].to_i
      },
      params: {
        "organization_id" => @organization.id,
        "start_date" => @start_date.strftime("%F"),
        "end_date" => @end_date.strftime("%F")
      }
    }
    token = JWT.encode payload, ENV["METABASE_SECRET_KEY"]

    @iframe_url = ENV["METABASE_SITE_URL"] + "/embed/dashboard/" + token + "#bordered=false&titled=false"
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

  protected

  def set_organization
    @organization ||= Current.organization
  end

  def set_sortable_columns
    @sortable_columns ||= %w[
      name
      balance_cents
      created_at
      updated_at
    ]
  end

  def set_scopable_values
    @scopable_values ||= ["all", ENUMS::ORGANIZATION_STATUSES.values].flatten
  end

  private

  def organization_params
    params.require(:organization).permit(
      :name,
      :account_manager_user_id,
      :creative_approval_needed,
      :url
    )
  end
end
