class ReferralsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def new
    if ENV["WORDPRESS_SITE_ENABLED"] == "true"
      return redirect_to("https://codefund.io/?referral_code=#{params[:referral_code]}")
    end

    session[:referral_code] = params[:referral_code]
    IncrementReferralLinkClickCountJob.perform_later params[:referral_code]

    if session[:referral_code] == "opencollective"
      redirect_to page_path("partners/opencollective")
    else
      redirect_to root_path
    end
  end
end
