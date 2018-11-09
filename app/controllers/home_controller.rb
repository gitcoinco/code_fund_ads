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
  end

  def advertisers
  end

  def create_advertiser
    ApplicantMailer.with(form: advertiser_application_params.to_h).advertiser_application_email.deliver_later
    redirect_to home_advertisers_path, notice: "Your request was sent successfully. We will be in touch."
  end

  def help
  end

  def team
  end

  private

    def advertiser_application_params
      params.require(:form).permit(:first_name, :last_name, :company_name, :company_url, :email, :monthly_budget)
    end

    def publisher_application_params
      params.require(:form).permit(:first_name, :last_name)
    end
end
