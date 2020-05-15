class UserEmailsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_view!
  before_action :set_user
  before_action :set_email, only: :show

  def index
    inbound_emails = @user.inbound_emails.order(delivered_at: :desc)
    @pagy, @emails = pagy(inbound_emails)
  end

  private

  def set_user
    @user = if authorized_user.can_admin_system?
      User.find(params[:user_id])
    else
      current_user
    end
  end

  def set_email
    @email = @user.inbound_emails.find(params[:id])
  end

  def authorize_view!
    render_forbidden unless authorized_user.can_view_emails?
  end
end
