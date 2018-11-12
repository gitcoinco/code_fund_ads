# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    # To be a showcase publisher, an image must exist at app/assets/images/home/browser-#{short_name}.png
    @showcase_publishers = [
      { short_name: "jsbin", url: "https://jsbin.com" },
      { short_name: "material-ui", url: "https://material-ui.com" },
      { short_name: "codesandbox", url: "https://codesandbox.io" },
      { short_name: "codier", url: "https://codier.io" },
      { short_name: "daily", url: "https://www.dailynow.co" },
      { short_name: "vuetify", url: "https://vuetifyjs.com" },
      { short_name: "redux-form", url: "https://redux-form.com" }
    ]
  end

  def publishers
  end

  def create_publisher
    CreateSlackNotificationJob.perform_later text: "<!channel> *Publisher Form Submission*", message: <<~MESSAGE
      *First Name:* #{publisher_application_params[:first_name]}
      *Last Name:*  #{publisher_application_params[:last_name]}
      *Email:*  #{publisher_application_params[:email]}
      *Monthly Visitors:*  #{publisher_application_params[:monthly_visitors]}
      *Website:*  #{publisher_application_params[:website_url]}
    MESSAGE
    ApplicantMailer.with(form: publisher_application_params.to_h).publisher_application_email.deliver_later
    redirect_to home_publishers_path, notice: "Your request was sent successfully. We will be in touch."
  end

  def advertisers
  end

  def create_advertiser
    CreateSlackNotificationJob.perform_later text: "<!channel> *Advertiser Form Submission*", message: <<~MESSAGE
      *First Name:* #{advertiser_application_params[:first_name]}
      *Last Name:*  #{advertiser_application_params[:last_name]}
      *Email:*  #{advertiser_application_params[:email]}
      *Company:*  #{advertiser_application_params[:company_name]}
      *Monthly Budget:*  #{advertiser_application_params[:monthly_budget]}
      *Website:*  #{advertiser_application_params[:company_url]}
    MESSAGE
    ApplicantMailer.with(form: advertiser_application_params.to_h).advertiser_application_email.deliver_later
    redirect_to home_advertisers_path, notice: "Your request was sent successfully. We will be in touch."
  end

  def help
  end

  def team
  end

  def create_newsletter_subscription
    CreateNewsletterSubscriptionJob.perform_later params[:email]
    redirect_back fallback_location: root_path, notice: "You are now subscribed."
  end

  private

    def advertiser_application_params
      params.require(:form).permit(:first_name, :last_name, :company_name, :company_url, :email, :monthly_budget)
    end

    def publisher_application_params
      params.require(:form).permit(:first_name, :last_name, :email, :monthly_visitors, :website_url)
    end
end
