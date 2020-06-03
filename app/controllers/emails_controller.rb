class EmailsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_view!
  before_action :set_email, only: :show

  def index
    emails = current_user.emails
    @current_filter = params[:filter] || "All"
    session[:email_date_format] ||= "default"

    emails =
      case @current_filter
      when "Unread" then emails.inbound.unread_by(current_user)
      when "Sent" then emails.outbound
      else emails.inbound
      end

    emails = emails.order(delivered_at: :desc)
    @pagy, @emails = pagy(emails)
  end

  def show
    @email.mark_read_for_user!(current_user) if true_user == current_user
  end

  private

  def set_email
    @email = current_user.emails.find(params[:id])
  end

  def authorize_view!
    render_forbidden unless authorized_user.can_view_emails?
  end
end
