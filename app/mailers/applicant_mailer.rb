class ApplicantMailer < ApplicationMailer
  before_action :set_inline_attachments

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
end
