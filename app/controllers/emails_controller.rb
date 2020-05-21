class EmailsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_view!
  before_action :set_email, only: :show

  def index
    emails = current_user.emails.order(delivered_at: :desc)
    @pagy, @emails = pagy(emails)
  end

  private

  def set_email
    @email = current_user.emails.find(params[:id])
  end

  def authorize_view!
    render_forbidden unless authorized_user.can_view_emails?
  end
end
