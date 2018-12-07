class PublishersController < ApplicationController
  # Creates a Publisher application, does not create a User record
  def create
    CreateSlackNotificationJob.perform_later text: "<!channel> *Publisher Form Submission*", message: <<~MESSAGE
      *First Name:* #{publisher_params[:first_name]}
      *Last Name:*  #{publisher_params[:last_name]}
      *Email:*  #{publisher_params[:email]}
      *Monthly Visitors:*  #{publisher_params[:monthly_visitors]}
      *Website:*  #{publisher_params[:website_url]}
    MESSAGE
    ApplicantMailer.with(form: publisher_params.to_h).publisher_application_email.deliver_later
    redirect_to publishers_path, notice: "Your request was sent successfully. We will be in touch."
  end

  private

  def publisher_params
    params.require(:form).permit(
      :email,
      :first_name,
      :last_name,
      :monthly_visitors,
      :website_url,
    )
  end
end
