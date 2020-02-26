class UserCampaignsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: :index

  def index
    campaigns = Campaign.includes(:organization).where(organization: @user.organizations).order_by_status
    @pagy, @campaigns = pagy(campaigns)
  end

  private

  def set_user
    @user = if authorized_user.can_admin_system?
      User.find(params[:user_id])
    else
      current_user
    end
  end
end
