class UsersMailer < ApplicationMailer
  default from: "alerts@codefund.io"
  layout "mailer"

  def new_consolidated_screening_list_flag_email(user)
    @user = user
    mail(
      to: "team@codefund.io",
      from: "alerts@codefund.io",
      subject: "Consolidated Screening List Flagged: #{@user&.name}",
    )
  end
end
