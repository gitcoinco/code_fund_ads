class UserOrganizationsController < ApplicationController
  before_action :set_user
  before_action :set_organizations_as_administrator
  before_action :set_organizations_as_owner
  before_action :set_organizations_as_member

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_organizations_as_administrator
    @organizations_as_administrator = @user.organizations_as_administrator
  end

  def set_organizations_as_member
    @organizations_as_member = @user.organizations_as_member
  end

  def set_organizations_as_owner
    @organizations_as_owner = @user.organizations_as_owner
  end
end
