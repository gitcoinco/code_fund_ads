class UserEmailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: :index

  def index
    emails = Email.with_email(@user.email).order(delivered_at: :desc)
    @pagy, @emails = pagy(emails)
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
