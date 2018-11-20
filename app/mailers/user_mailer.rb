class UserMailer < ApplicationMailer
  default from: "noreply@codefund.io"
  layout "mailer"

  def password_changed
    mail(to: params[:email], subject: "[CodeFund.io] Password Reset")
  end
end
