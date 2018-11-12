class PublishersController < ApplicationController
  def create
    CreateSlackNotificationJob.perform_later text: "<!channel> *Publisher Form Submission*", message: <<~MESSAGE
      *First Name:* #{publisher_application_params[:first_name]}
      *Last Name:*  #{publisher_application_params[:last_name]}
      *Email:*  #{publisher_application_params[:email]}
      *Monthly Visitors:*  #{publisher_application_params[:monthly_visitors]}
      *Website:*  #{publisher_application_params[:website_url]}
    MESSAGE
    ApplicantMailer.with(form: publisher_params.to_h).publisher_application_email.deliver_later
    redirect_to home_publishers_path, notice: "Your request was sent successfully. We will be in touch."
  end

  private

    def publisher_params
      params.require(:form).permit(:first_name, :last_name, :email, :monthly_visitors, :website_url)
    end
end
