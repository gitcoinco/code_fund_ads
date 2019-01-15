class ApplicantMailer < ApplicationMailer
  before_action :set_inline_attachments, except: [:response_to_applicant_email]

  def advertiser_application_email
    @form = params[:form]
    @name = "#{@form[:first_name]} #{@form[:last_name]}"

    mail(to: "team@codefund.io", from: @form[:email], subject: "Advertiser from submission by #{@name}")
  end

  def publisher_application_email
    @form = params[:form]
    @name = "#{@form[:first_name]} #{@form[:last_name]}"

    mail(to: "team@codefund.io", from: @form[:email], subject: "Publisher from submission by #{@name}")
  end

  def response_to_applicant_email
    mail(to: params[:email], from: "eric@codefund.io", subject: params[:subject], body: params[:body], content_type: "text/plain")
  end
end
