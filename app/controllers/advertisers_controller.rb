class AdvertisersController < ApplicationController
  # Creates an Advertiser application, does not create a User record
  def create
    CreateSlackNotificationJob.perform_later text: "<!channel> *Advertiser Form Submission*", message: <<~MESSAGE
      *First Name:* #{advertiser_params[:first_name]}
      *Last Name:*  #{advertiser_params[:last_name]}
      *Email:*  #{advertiser_params[:email]}
      *Company:*  #{advertiser_params[:company_name]}
      *Monthly Budget:*  #{advertiser_params[:monthly_budget]}
      *Website:*  #{advertiser_params[:company_url]}
    MESSAGE
    ApplicantMailer.with(form: advertiser_params.to_h).advertiser_application_email.deliver_later
    redirect_to advertisers_path, notice: "Your request was sent successfully. We will be in touch."
  end

  private

  def advertiser_params
    params.require(:form).permit(
      :company_name,
      :company_url,
      :email,
      :first_name,
      :last_name,
      :monthly_budget,
    )
  end
end
