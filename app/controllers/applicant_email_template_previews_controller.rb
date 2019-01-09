class ApplicantEmailTemplatePreviewsController < ApplicationController
  before_action :authenticate_administrator!
  before_action :set_applicant
  before_action :set_email_template

  def show
    return render json: {subject: "", body: ""} unless @email_template && @applicant

    subject_template = Liquid::Template.parse(@email_template.subject)
    body_template = Liquid::Template.parse(@email_template.body)
    subject = subject_template.render(@applicant.liquid_attributes)
    body = body_template.render(@applicant.liquid_attributes)
    render json: {
      subject: subject,
      body: body,
    }
  end

  private

  def set_applicant
    @applicant = Applicant.find(params[:applicant_id])
  end

  def set_email_template
    @email_template = EmailTemplate.find(params[:email_template_id])
  end
end
