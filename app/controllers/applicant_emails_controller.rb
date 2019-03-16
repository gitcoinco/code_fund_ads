class ApplicantEmailsController < ApplicationController
  before_action :authenticate_administrator!
  before_action :set_applicant

  def create
    subject = email_params[:subject]
    body = email_params[:body]
    ApplicantMailer.with(email: @applicant.email, subject: subject, body: body).response_to_applicant_email.deliver_later
    @applicant.add_event("Sent email:\n\n#{body}", ["email"])
    redirect_to applicant_events_path(@applicant), notice: "Email was sent successfully"
  end

  private

  def set_applicant
    @applicant = Applicant.find(params[:applicant_id])
  end

  def email_params
    params.require(:applicant).permit(:subject, :body)
  end
end
