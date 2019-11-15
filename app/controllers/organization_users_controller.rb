class OrganizationUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization

  def index
    organization_users = @organization.organization_users.order(role: :asc)
    @pagy, @organization_users = pagy(organization_users)
  end

  private

  def set_organization
    @organization = Current.organization
  end
end
